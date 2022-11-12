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

" Some alternatives here:
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim
" ColorColumn lets you highlight the background
" Match lets you highlight just the chars which are over a given length
set textwidth=90
let &colorcolumn=join(range(&textwidth + 1,1000),",")
highlight ColorColumn ctermbg=Black

" Easier navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
