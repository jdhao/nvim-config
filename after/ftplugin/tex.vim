" Only use the following character pairs for tex file
if &runtimepath =~? 'auto-pairs'
    let b:AutoPairs = AutoPairsDefine({'<' : '>'})
    let b:AutoPairs = {'(':')', '[':']', '{':'}', '<':'>'}
endif
set textwidth=79
