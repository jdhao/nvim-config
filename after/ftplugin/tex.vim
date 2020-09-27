" Only use the following character pairs for tex file
if match(&runtimepath, 'auto-pairs') != -1
  let b:AutoPairs = AutoPairsDefine({'<' : '>'})
  let b:AutoPairs = {'(':')', '[':']', '{':'}', '<':'>'}
endif
set textwidth=79
