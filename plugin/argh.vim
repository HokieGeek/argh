if exists("g:loaded_argh") || v:version < 700
    finish
endif
let g:loaded_argh = 1

command! ArgsOnly :call argh#RemoveNonArgBuffers()
command! Only :call argh#DeleteAllOtherBuffers()
command! -nargs=* -complete=buffer ArgsToggle :call argh#ArgumentsToggle(<f-args>)
command! -nargs=+ -complete=file Badd :call argh#AddBuffers(<q-args>)
