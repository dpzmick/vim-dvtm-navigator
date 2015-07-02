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
else
    command! DvtmNavigateLeft     <C-w>h
    command! DvtmNavigateDown     <C-w>j
    command! DvtmNavigateUp       <C-w>k
    command! DvtmNavigateRight    <C-w>l
endif

