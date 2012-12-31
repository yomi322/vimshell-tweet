let s:save_cpo = &cpo
set cpo&vim


let s:command = { 'name': 'tweet',
\                 'kind': 'internal',
\                 'description': 'tweet {message}...' }

function! vimshell#commands#tweet#define()
  return s:command
endfunction


function! s:command.execute(args, context)
  try
    return call('tweetvim#say#command', [join(a:args)])
  catch /^Vim\%((\a\+)\)\=:E117/
    return
  endtry
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
