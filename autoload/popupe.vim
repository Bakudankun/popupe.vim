vim9script


export def PopupInput(Callback: func(string),
                      text: string = '',
                      completion: string = '',
                      options: dict<any> = {}): number
  const opts = options->extendnew({
    maxheight: 1,
    minheight: 1,
    minwidth: 20,
    wrap: 0,
    scrollbar: 0,
    callback: (winid: number, result: any) =>
      Callback(type(result) == v:t_string ? result : null_string),
  }, 'keep')

  const winid = CreateEditablePopup(opts)

  popup_settext(winid, text)

  :inoremap <buffer> <CR> <Cmd>stopinsert<CR><ScriptCmd>popup_close(win_getid(), term_getline('', '.'))<CR>
  :inoremap <buffer> <Esc> <Cmd>stopinsert<CR><ScriptCmd>popup_close(win_getid(), null_string)<CR>
  :imap <buffer> <C-C> <Esc>

  :startinsert!
  return winid
enddef


export def PopupEdit(text: any, options: dict<any>): number
  const winid = CreateEditablePopup(options)
  popup_settext(winid, text)
  return winid
enddef


def CreateEditablePopup(options: dict<any>): number
  const buf = term_start('NONE', {
    term_name: 'popupe',
    hidden: 1,
    term_highlight: 'Pmenu',
  })
  term_getjob(buf)->ch_close()
  for [option, value] in items({
      modifiable: 1,
      buftype: 'popup',
      })
    setbufvar(buf, $'&{option}', value)
  endfor

  const winid = popup_create(buf, options)
  return winid
enddef


# vim: et sts=-1 sw=2
