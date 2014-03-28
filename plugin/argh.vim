command! ArgsOnly :call argh#RemoveNonArgBuffers()
command! Only :call argh#DeleteAllBuffersOtherThanCurrent()
command! -nargs=* -complete=buffer ArgsToggle :call argh#ArgumentsToggle(<f-args>)
