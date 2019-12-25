#!/usr/bin/env python

# Copyright (C) 2013-2018 John Szakmeister <john@szakmeister.net>
# All rights reserved.
#
# This software is licensed as described in the file LICENSE.txt, which
# you should have received as part of this distribution.

import sys
import re


class ScriptError(Exception):
    pass


def ctagNameEscape(text):
    return re.sub('[\t\r\n]+', ' ', text)


def ctagSearchEscape(text):
    text = text.replace('\t', r'\t')
    text = text.replace('\r', r'\r')
    text = text.replace('\n', r'\n')
    text = text.replace('\\', r'\\')
    return text


class Tag():
    def __init__(self, tagName, tagFile, tagAddress):
        self.tagName = tagName
        self.tagFile = tagFile
        self.tagAddress = tagAddress
        self.fields = []

    def addField(self, field_type, value=None):
        if field_type == 'kind':
            field_type = None
        self.fields.append((field_type, value or ""))

    def _formatFields(self):
        formattedFields = []
        for name, value in self.fields:
            if name:
                s = '%s:%s' % (name, value or "")
            else:
                s = str(value)
            formattedFields.append(s)
        return '\t'.join(formattedFields)

    def __str__(self):
        return '%s\t%s\t%s;"\t%s' % (
            self.tagName, self.tagFile, self.tagAddress, self._formatFields())

    def __repr__(self):
        return "<Tag name:%s file:%s: addr:%s %s>" % (
            self.tagName, self.tagFile, self.tagAddress,
            self._formatFields().replace('\t', ' '))

    def __eq__(self, other):
        return str(self) == str(other)

    def __ne__(self, other):
        return str(self) != str(other)

    def __lt__(self, other):
        return str(self) < str(other)

    def __le__(self, other):
        return str(self) <= str(other)

    def __gt__(self, other):
        return str(self) > str(other)

    def __ge__(self, other):
        return str(self) >= str(other)

    @staticmethod
    def section(section, sro):
        tagName = ctagNameEscape(section.name)
        tagAddress = '/^%s$/' % ctagSearchEscape(section.line)
        t = Tag(tagName, section.filename, tagAddress)
        t.addField('kind', 's')
        t.addField('line', section.lineNumber)

        parents = []
        p = section.parent
        while p is not None:
            parents.append(ctagNameEscape(p.name))
            p = p.parent
        parents.reverse()

        if parents:
            t.addField('section', sro.join(parents))

        return t


class Section():
    def __init__(self, level, name, line, lineNumber, filename, parent=None):
        self.level = level
        self.name = name
        self.line = line
        self.lineNumber = lineNumber
        self.filename = filename
        self.parent = parent

    def __repr__(self):
        return '<Section %s %d %d>' % (self.name, self.level, self.lineNumber)


def popSections(sections, level):
    while sections:
        s = sections.pop()
        if s and s.level < level:
            sections.append(s)
            return


atxHeadingRe = re.compile(r'^(#+)\s+(.*?)(?:\s+#+)?\s*$')
settextHeadingRe = re.compile(r'^[-=]+$')
settextSubjectRe = re.compile(r'^[^\s]+.*$')


def findSections(filename, lines):
    sections = []
    inCodeBlock = False
    beyondFrontMatter = False
    inFrontMatter = False

    previousSections = []

    for i, line in enumerate(lines):
        # Some markdown-based tools allow for "front matter" at the beginning
        # of the file.  The data is demarcated by a leading and trailing triple
        # hyphen (---) on its own line.  The tools I've looked at, like Jekyll,
        # expect this to start on the first line.  So here's an attempt to skip
        # over the front matter and only tag the remaining part of the file.
        if not beyondFrontMatter:
            if line == "":
                continue
            elif line == '---':
                inFrontMatter = not inFrontMatter
                continue

            if not inFrontMatter and line:
                beyondFrontMatter = True


        # Skip GitHub Markdown style code blocks.
        if line.startswith("```"):
            inCodeBlock = not inCodeBlock
            continue

        if inCodeBlock:
            continue

        m = atxHeadingRe.match(line)
        if m:
            level = len(m.group(1))
            name = m.group(2)

            popSections(previousSections, level)
            if previousSections:
                parent = previousSections[-1]
            else:
                parent = None
            lineNumber = i + 1

            s = Section(level, name, line, lineNumber, filename, parent)
            previousSections.append(s)
            sections.append(s)
        else:
            m = settextHeadingRe.match(line)
            if i and m:
                if not settextSubjectRe.match(lines[i - 1]):
                    continue

                name = lines[i-1].strip()

                if line[0] == '=':
                    level = 1
                else:
                    level = 2

                popSections(previousSections, level)
                if previousSections:
                    parent = previousSections[-1]
                else:
                    parent = None
                lineNumber = i

                s = Section(level, name, lines[i-1], lineNumber,
                            filename, parent)
                previousSections.append(s)
                sections.append(s)

    return sections


def sectionsToTags(sections, sro):
    tags = []

    for section in sections:
        tags.append(Tag.section(section, sro))

    return tags


def genTagsFile(output, tags, sort):
    if sort == "yes":
        tags = sorted(tags)
        sortedLine = b'!_TAG_FILE_SORTED\t1\n'
    elif sort == "foldcase":
        tags = sorted(tags, key=lambda x: str(x).lower())
        sortedLine = b'!_TAG_FILE_SORTED\t2\n'
    else:
        sortedLine = b'!_TAG_FILE_SORTED\t0\n'

    output.write(b'!_TAG_FILE_FORMAT\t2\n')
    output.write(sortedLine)

    for t in tags:
        output.write(str(t).encode('utf-8'))
        output.write(b'\n')


def main():
    from optparse import OptionParser

    parser = OptionParser(usage="usage: %prog [options] file(s)")

    parser.add_option(
        "-f", "--file", metavar="FILE", dest="tagfile",
        default="tags",
        help='Write tags into FILE (default: "tags").  Use "-" to write '
             'tags to stdout.')
    parser.add_option(
        "", "--sort", metavar="[yes|foldcase|no]", dest="sort",
        choices=["yes", "no", "foldcase"],
        default="yes",
        help='Produce sorted output.  Acceptable values are "yes", '
             '"no", and "foldcase".  Default is "yes".')
    parser.add_option(
        "", "--sro", metavar="SEPARATOR", dest="sro",
        default="|", action="store",
        help=u'Use the specified string to scope nested headings. The '
              'default is pipe symbol ("|"), but that can be an issue if your '
              'headings contain the pipe symbol.  It might be more useful to '
              'use a such as the UTF-8 chevron ("\u00bb").')

    options, args = parser.parse_args()

    if options.tagfile == '-':
        output = sys.stdout.buffer
    else:
        output = open(options.tagfile, 'wb')

    for filename in args:
        f = open(filename, 'r', encoding='utf-8', newline='')

        lines = f.read().splitlines()
        f.close()
        sections = findSections(filename, lines)

        genTagsFile(output,
                    sectionsToTags(sections, options.sro),
                    sort=options.sort)

    output.flush()
    output.close()


def cli_main():
    try:
        main()
    except IOError as e:
        import errno
        if e.errno == errno.EPIPE:
            # Exit saying we got SIGPIPE.
            sys.exit(141)
        raise
    except ScriptError as e:
        print("ERROR: %s" % str(e), file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    cli_main()
