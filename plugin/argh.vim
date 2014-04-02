if exists("g:loaded_argh") || v:version < 700
    finish
endif
let g:loaded_argh = 1

command! -bar ArgsOnly :call argh#RemoveNonArgBuffers()
command! -bar Only :call argh#DeleteAllOtherBuffers()
command! -bar -nargs=* -complete=buffer ArgsToggle :call argh#ArgumentsToggle(<f-args>)
command! -bar -bang -nargs=+ -complete=file Badd :call argh#AddBuffers(<bang>0, <q-args>)
command! -bar -bang -nargs=* -complete=buffer Bd :call argh#DelBuffers(<bang>0, <q-args>)
