function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

function! s:IsDvtm()
    return exists('$DVTM') && exists('$DVTM_CMD_FIFO')
endfunction

function! s:DvtmNavigate(direction, dvtmcmd)
    let previous_winnr = winnr()
    call s:VimNavigate(wincmd)
    if previous_winnr == winnr()
        call system( "echo " . a:dvtmcmd . " > " . $DVTM_CMD_FIFO )
        redraw!
    endif
endfunction

function! s:DvtmOrSplitSwitch(direction, dvtmcmd)
    if s:IsDvtm()
        call s:DvtmNavigate(a:direction, a:dvtmcmd)
    else
        call s:VimNavigate(a:direction)
    endif
endfunction

command! DvtmNavigateLeft     call <SID>DvtmOrSplitSwitch('h', 'focusleft')
command! DvtmNavigateDown     call <SID>DvtmOrSplitSwitch('j', 'focusdown')
command! DvtmNavigateUp       call <SID>DvtmOrSplitSwitch('k', 'focusup')
command! DvtmNavigateDown     call <SID>DvtmOrSplitSwitch('j', 'focusdown')
