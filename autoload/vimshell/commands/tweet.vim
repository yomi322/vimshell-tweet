let s:save_cpo = &cpo
set cpo&vim


let s:command = { 'name': 'tweet',
\                 'kind': 'internal',
\                 'description': 'tweet {message}...' }

function! vimshell#commands#tweet#define()
  return s:command
endfunction


function! s:command.execute(args, context)
  if exists(':TweetVimCommandSay')
    execute 'TweetVimCommandSay' join(a:args)
    return
  else
    let message = 'TweetVim is not available'
    call vimshell#error_line(a:context.fd, message)
  endif
endfunction


function! s:command.complete(args)
  let arglead = a:args[-1]
  if arglead =~# '^@'
    let comp = map(tweetvim#cache#get('screen_name'),
    \              "{ 'word': '@' . v:val, 'menu': 'tweet' }")
    return vimshell#complete#helper#keyword_filter(comp, arglead)
  elseif arglead =~# '^#'
    let comp = map(tweetvim#cache#get('hash_tag'),
    \              "{ 'word': '#' . v:val, 'menu': 'tweet' }")
    return vimshell#complete#helper#keyword_filter(comp, arglead)
  else
    return []
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
