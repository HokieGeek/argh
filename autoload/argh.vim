if exists("g:autoloaded_argh") || v:version < 700
    finish
endif
let g:autoloaded_argh = 1

function! argh#RemoveNonArgBuffers()
    let l:not_args = filter(range(1, bufnr('$')), 'buflisted(v:val) && index(argv(), bufname(v:val)) == -1')
    if len(l:not_args) > 0
        execute "bdelete! ".join(l:not_args, ' ')
    endif
endfunction

function! argh#ArgumentsToggle(...)
    if a:0 > 0
        let l:listed = filter(a:000, 'buflisted(v:val)')
        let l:args = filter(l:listed, 'index(argv(), bufname(v:val)) != -1')
        let l:not_args = filter(l:listed, 'index(argv(), bufname(v:val)) == -1')
        if len(l:not_args) > 0
            execute "argadd ".join(l:not_args, ' ')
        endif
        if len(l:args) > 0
            execute "argdelete ".join(l:args, ' ')
        endif
    else
        if index(argv(), bufname("%")) == -1
            execute "argadd %"
        else
            execute "argdelete %"
        endif
    endif
endfunction

function! argh#AddAllBuffersAsArgs()
    let l:not_args = filter(range(1, bufnr('$')), 'buflisted(v:val) && index(argv(), bufname(v:val)) == -1')
    let l:not_args = map(l:not_args, 'bufname(v:val)')
    if len(l:not_args) > 0
        execute "argadd ".join(l:not_args, ' ')
    endif
endfunction

function! argh#DeleteAllOtherBuffers()
    let l:all_others = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != bufnr("%")')
    if len(l:all_others) > 0
        execute "bdelete! ".join(l:all_others, ' ')
    endif
endfunction

function! argh#AddBuffers(addarg, files)
    for f in split(a:files)
        for g in split(glob(f))
            if filereadable(g)
                execute "badd ".g
                if a:addarg
                    execute "argadd ".g
                endif
            endif
        endfor
    endfor
endfunction

function! argh#DelBuffers(delarg, buffers)
    let l:buffers = (strlen(a:buffers) > 0) ? a:buffers : bufname("%")
    for b in split(l:buffers)
        for g in split(glob(b))
            silent! execute "bdelete! ".g
            if a:delarg
                silent! execute "argdelete ".g
            endif
        endfor
    endfor
endfunction
