" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Load pathogen for managing all those pesky plugins.
" Load this first so ftdetect in bundles works properly.
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

syntax on                              " enable syntax highlighting
set history=50                         " keep 50 lines of command line history
set showcmd                            " display incomplete commands
set incsearch                          " do incremental searching
set hlsearch                           " highlight search results
set mouse=a                            " enable the mouse
set expandtab                          " always use spaces not tabs
set ts=2 sw=2 sts=2                    " default to 2 space tabs
set autoindent nosmartindent nocindent " go for simple autoindenting
set hidden                             " unload any buffer that's hidden
set wildmode=list:longest              " list options when completing on the command line
set scrolloff=5                        " scroll 5 lines before the cursor hits the edge
set relativenumber                     " show line numbers relative to the current line
set autowriteall                       " autosave lots of the time
set autoread                           " pick up changed files automatically
set splitright                         " make new splits open to the right

" Try out Gary Bernhardt's window sizing strategy.
if has("gui_macvim")
  set lines=50  " Make sure our window is big enough to start with.
endif
set winwidth=79
set winheight=5
set winminheight=5
set winheight=999

" Remove whitespace at the end of lines on save.
" See http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Set up the status line
set laststatus=2        " Always show it.
set statusline=%([%M%R%H%W]\ \ %)%l/%L\ \ %f%=%{&filetype}\ \ %c
hi StatusLine guifg=#888888 guibg=black
hi StatusLineNC guifg=#222222 guibg=white

" Put swap files in /tmp, and don't keep backups.
set dir=/tmp
set nobackup

" Set up folding.
set foldenable         " enable code folding
set foldmethod=syntax  " use syntax for folding
set foldlevelstart=99  " open all folds by default
set foldtext=getline(v:foldstart)
set fillchars=fold:\   " nicer folding

if has("gui_macvim")
  set mousehide                   " Hide the mouse when typing text.
  set guioptions=egm              " Show tabs, hide toolbar and scrollbar.
  set fuoptions=maxvert,maxhorz   " Go to full width and height in full screen mode.

  set gfn=Inconsolata:h15         " Inconsolata 15px for the font
  set linespace=0                 " 0 pixels between lines

  colorscheme railscasts

  " Colour tweaks.
  highlight Folded guifg=#EEEEEE guibg=#333333
  highlight LineNr guifg=#333333 ctermfg=159 guibg=#111111

  " Popup menu colours, borrowed from http://www.vim.org/scripts/script.php?script_id=1995
  highlight Pmenu      guifg=#F6F3E8 guibg=#444444 gui=NONE
  highlight PmenuSel   guifg=#000000 guibg=#A5C261 gui=NONE
  highlight PMenuSbar  guibg=#5A647E gui=NONE
  highlight PMenuThumb guibg=#AAAAAA gui=NONE

  " Write files on loss of focus.
  autocmd FocusLost * silent! wa
endif

" Completion
set complete=.,w,b,u  " Scan all the buffers.


" Plugin Configuration
" --------------------

" Stop Lusty Juggler complaining when we use the system vim.
let g:LustyJugglerSuppressRubyWarning = 1

" Show relative paths in bufexplorer.
let g:bufExplorerShowRelativePath=1
" Hide the default help in bufexplorer.
let g:bufExplorerDefaultHelp=0


" Custom Key Mappings
" -------------------

" Use , as the leader key.
let mapleader=","

" Use jj to get out of insert mode.
imap jj <esc>

" Disable the F1 key (which normally opens help) coz I hit it accidentally.
noremap <F1> <nop>

" Buffer navigation.
noremap <Leader>a :LustyBufferExplorer<CR>
noremap <Leader>r :LustyFilesystemExplorerFromHere<CR>
noremap <Leader>m :set columns=120 lines=40<CR>

noremap <Leader>t :CtrlP<CR>
noremap <Leader>gv :CtrlP app/views<cr>
noremap <Leader>gc :CtrlP app/controllers<cr>
noremap <Leader>gm :CtrlP app/models<cr>
noremap <Leader>gh :CtrlP app/helpers<cr>
noremap <Leader>gs :CtrlP spec<cr>
noremap <Leader>gf :CtrlP features<cr>

" Use CTRL-J and CTRL-K to skip forward and back through functions.
map <C-K> [m
map <C-J> ]m

" Use CTRL-N and CTRL-P to skip forward and back through the quickfix list.
noremap <C-P> :cp<CR>
noremap <C-N> :cn<CR>

" Use CTRL-A to re-align ruby, SQL, and cucumber in visual mode.
vnoremap <C-A> !align-ruby<CR>

" Reselect the visual area when changing indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" Don't use Ex mode, use Q for formatting.
noremap Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Map Command-R to save and run the current spec file in iTerm.
noremap <D-r> :w<CR>:Spec<CR>

" Map arrow keys to move lines around (relies on vim-unimpaired plugin.)
" Idea from: http://codingfearlessly.com/2012/08/21/vim-putting-arrows-to-use/
nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

" Filetype Handling
" -----------------

" Enable file type detection, but disable smart indenting.
filetype plugin on
filetype indent off

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcCommands
autocmd!

autocmd BufRead,BufNewFile *.pde  set filetype=cpp
autocmd BufRead,BufNewFile *.ncss set filetype=css

autocmd FileType text       setlocal textwidth=78
autocmd FileType html       setlocal ts=2 sw=2 sts=2
autocmd FileType xhtml      setlocal ts=2 sw=2 sts=2
autocmd FileType css        setlocal ts=2 sw=2 sts=2
autocmd FileType javascript setlocal ts=2 sw=2 sts=2
autocmd FileType c          setlocal ts=4 sw=4 sts=4
autocmd FileType cpp        setlocal ts=4 sw=4 sts=4
autocmd FileType ruby       setlocal ts=2 sw=2 sts=2
autocmd FileType eruby      setlocal ts=2 sw=2 sts=2
autocmd FileType cucumber   setlocal ts=2 sw=2 sts=2
autocmd FileType markdown   setlocal ts=4 sw=4 sts=4 foldmethod=marker foldlevel=0

augroup END
