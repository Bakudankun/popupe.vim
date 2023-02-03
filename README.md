# Popupe.vim

Popupe.vim provides some functions that creates editable popups by hacking
Vim's terminal popup window. This is really hacky so it can be broken by future
change of Vim. Please use this at your own risk.

For further information, see the [doc](doc/popupe.txt).


## Example

```vim
vim9script

import autoload 'popupe.vim'

popupe.PopupInput((result: string) => {
  if result is null_string
    echo 'Cancelled'
  else
    echo result
  endif
})
```

