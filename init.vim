" search settings
set incsearch   " start searching immediately 
set hlsearch    " highlight results
set ignorecase  " ignore case...
set smartcase   " ... unless i use an uppercase letter

set scrolloff=5  " when motioning always show some context
                 " to the line i jump to

set number       " absolute line numbers on the left

" :noh is a lot of typing
noremap <CR> :noh<CR><CR>

set mouse=a  " the mouse is usable in all modes

" Easier navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" jump between files
nnoremap <space>f <cmd>Telescope find_files<cr>
nnoremap <space>r <cmd>Telescope oldfiles<cr>
nnoremap <space>o <cmd>Telescope treesitter<cr>
nnoremap <space>l <cmd>Telescope builtin<cr>
nnoremap <space>d <cmd>Telescope lsp_definitions<cr>
nnoremap <space>rr <cmd>Telescope lsp_references<cr>

" pathfinding through semantic space
inoremap <M-Bslash> <plug>(copilot-suggest)
inoremap <M-'> <plug>(ale_complete)

set cursorline  " highlight the line the cursor is on

autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set autoindent
autocmd FileType python set expandtab
autocmd FileType python set softtabstop=4

autocmd FileType c set noexpandtab
autocmd FileType c set tabstop=4
autocmd FileType c set shiftwidth=4

autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal textwidth=72

autocmd FileType rust set textwidth=100  " this is the rustfmt default

lua require('lspconfig').rust_analyzer.setup{}

let g:ale_linters = { 'rust': ['analyzer'] }
let g:ale_fixers = { 'rust': ['rustfmt'] }
let g:ale_sign_column_always = 1

call coc#config('languageserver', {
	\ 'rust': {
	\   'command': 'rust-analyzer',
	\   'filetypes': ['rust'],
	\   'rootPatterns': ['Cargo.toml'],
	\   'initializationOptions': {},
	\   'settings': {}
	\ }})
call coc#config('rust-analyzer.serverPath', 'rust-analyzer')

"
" START highlight textwidth

  " - Some alternative implementations here:
  "   - http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
  "   - http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim
  " - ColorColumn lets you highlight the background
  " - Match lets you highlight just the chars which are over a given length

  highlight ColorColumn ctermbg=Black
  function s:HighlightCorrectColumns()
    let &colorcolumn=join(range(&textwidth + 1,1000),",")
  endfunction
  autocmd OptionSet textwidth call s:HighlightCorrectColumns()

  " autocmd OptionSet does not run during startup so we call it manually
  set textwidth=90
  call s:HighlightCorrectColumns()

" END highlight textwidth
