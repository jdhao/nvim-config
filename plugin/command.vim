" Capture output from a command to register @m, to paste, press "mp
command! -nargs=1 -complete=command Redir call utils#CaptureCommandOutput(<q-args>)

command! -bar -bang -nargs=+ -complete=file Edit call utils#MultiEdit([<f-args>])
call utils#Cabbrev('edit', 'Edit')
