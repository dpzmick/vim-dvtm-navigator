if exists('$DVTM') && exists('$DVTM_CMD_FIFO')
    function! DvtmOrSplitSwitch(wincmd, dvtmcmd)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system( "echo " . a:dvtmcmd . " > " . $DVTM_CMD_FIFO )
            redraw!
        endif
    endfunction

    command! DvtmNavigateLeft     call <SID>DvtmOrSplitSwitch('h', 'focusleft')
    command! DvtmNavigateDown     call <SID>DvtmOrSplitSwitch('j', 'focusdown')
    command! DvtmNavigateUp       call <SID>DvtmOrSplitSwitch('k', 'focusup')
    command! DvtmNavigateRight    call <SID>DvtmOrSplitSwitch('l', 'focusright')

    nnoremap <silent> <C-h> :call DvtmOrSplitSwitch('h', 'focusleft')<cr>
    nnoremap <silent> <C-j> :call DvtmOrSplitSwitch('j', 'focusdown')<cr>
    nnoremap <silent> <C-k> :call DvtmOrSplitSwitch('k', 'focusup')<cr>
    nnoremap <silent> <C-l> :call DvtmOrSplitSwitch('l', 'focusright')<cr>
else
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
endif
