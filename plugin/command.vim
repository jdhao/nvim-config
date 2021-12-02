" Capture output from a command to register @m, to paste, press "mp
command! -nargs=1 -complete=command Redir call utils#CaptureCommandOutput(<q-args>)

command! -bar -bang -nargs=+ -complete=file Edit call utils#MultiEdit([<f-args>])
call utils#Cabbrev('edit', 'Edit')

call utils#Cabbrev('man', 'Man')

" show current date and time in human readable format
command! -nargs=? Datetime echo utils#iso_time(<q-args>)
