" Returns true if the given file belongs to your test runner
function! test#raku#mi6#test_file(file)
    return a:file =~# g:test#perl#prove#file_pattern
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#raku#mi6#build_position(type, position)
    if a:type ==# 'file' || a:type ==# 'nearest'
        return [a:position['file']]
    else
        return []
    endif
endfunction

" Returns processed args (if you need to do any processing)
function! test#raku#mi6#build_args(args)
    return a:args
endfunction

" Returns the executable of your test runner
function! test#raku#mi6#executable()
    return 'mi6 test'
endfunction
