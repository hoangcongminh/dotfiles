vim.cmd([[
let g:vscode_style = "dark"
let g:vscode_transparent = 0.8
let g:vscode_italic_comment = 1

colorscheme vscode

" custom style
 highlight Normal guibg=NONE ctermbg=NONE
 highlight LineNr guibg=NONE ctermbg=NONE
 highlight SignColumn guibg=NONE ctermbg=NONE
 highlight EndOfBuffer guibg=NONE ctermbg=NONE
 highlight NvimTreeNormal guibg=NONE
 highlight BufferTabpageFill guibg=none
 highlight CursorLineNr guibg=NONE 
 highlight LspDiagnosticsUnderlineInformation guifg=NONE
 highlight LspDiagnosticsUnderlineError guifg=NONE

 highlight NvimTreeCursorline gui=underline cterm=underline guibg=NONE
 highlight Comment gui=italic
 highlight link GitSignsCurrentLineBlame Comment
 highlight NvimTreeFolderIcon guibg=blue

 set cursorline
 hi clear CursorLine
 hi! CursorLine gui=underline cterm=underline
]])
