" snappet fra Tobias V. Langhoff (tobiasvl@ifi.uio.no)
" http://folk.uio.no/tobiasvl/.vimrc
" http://bitbucket.org/tobiasvl/dotfiles/src/tip/.vimrc

" Pathogen
call pathogen#infect() 

set nocompatible
filetype indent on  " choose indentation based on file type
filetype plugin on  " load plugin files for specific file types
set grepprg=grep\ -nH\ $* " fix grep for LaTeX-suite

" folding
set foldmethod=indent " fold indented regions
set foldnestmax=10
set nofoldenable
set foldlevel=1     " fold from the beginning

" misc
syntax enable       " enable syntax highlighting
"set spell           " spell check
set ruler           " show line info
set laststatus=2    " always show statusbar
set showcmd         " show partially typed commands
set showmode        " show the current mode
"set mouse=a         " enable mouse (hold shift for regular xterm mouse action)
set backspace=2     " make backspace sane (set backspace=eol,start,indent ?)
"set gdefault        " imply g (entire line) when searching and replacing
set whichwrap=b,s,h,l,~,[,],<,> " wrap to the next line with these keys
set showmatch       " briefly jump to matching parenthesis when writing one
set matchpairs=(:),{:},[:],<:> " match these with each other (with %)
"source ~/.vim/plugin/matchit.vim (TODO last ned denne)
"let b:match_words='<:>,<tag>:</tag>,if:fi' " match these with each other (with %)
set wrap            " wrap long lines
set showbreak=\     " display this at the start of wrapped lines
"set noendofline     " don't write <EOL> at the end of file
"set cursorline      " highlight the current line
"set lazyredraw      " faster
"set encoding=utf-8  " set encoding to utf-8
set statusline=%<%F\ %h%m%r%w\ (%Y)%=%-14.(%l,%c%V%)\ %P " see :help statusline
let html_use_css=1  " use CSS when doing a :TOhtml
let use_xhtml=1     " use XHTML when doing a :TOhtml o/~
"set autochdir       " cwd to directory of current file
set noerrorbells
set novisualbell
set wildmenu        " proper tab completion in normal mode
set wildmode=longest:full,full
set wildignore=.dll,.o,.obj, " do not list these file extensions
              \.bak,.exe,.pyc,.jpg,.gif,.png,.wmv,.pdf,.avi,.mpg,
                \.divx,.so,.a

" Fold/unfold JavaDoc
nmap \j :g/\/\*\*/ foldo<CR>:nohls<CR>
nmap \J :g/\/\*\*/ foldc<CR>:nohls<CR>

" search
set hlsearch        " highlight search terms
set incsearch       " search while typing
set ignorecase      " ignore case when searching ...
set smartcase       " ... except when the search term specifically contains uppercase
set infercase

" colors
colorscheme ir_black "best color schemes: peachpuff, default, elflord, desert
highlight LineNr    ctermfg=darkgrey guifg=darkgrey
"highlight Comment   ctermfg=darkblue
"highlight ModeMsg   cterm=NONE ctermfg=white guifg=white
highlight Search    ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
highlight Pmenu     ctermbg=blue cterm=bold
set background=dark


" indenting (note: I hate tabs and love spaces, comment out accordingly)
set autoindent      " auto-indent new lines
set smartindent     " auto-indent things in braces
set expandtab       " away with those pesky tabs
set shiftwidth=4    " number of spaces per indent level
set softtabstop=4   " number of spaces to e.g. delete with backspace
set cindent         " auto-indent things in braces, loops, conditions, etc.
set formatoptions+=ro " keep indenting block comments
match errorMsg /[\t]/ " highlight all tab characters as errors
"set shiftround

" LaTeX-suite, see http://vim-latex.sourceforge.net/
set iskeyword+=:    " for \ref{fig: CTRL+N
let g:tex_flavor='latex' " correct file type for LaTeX

" Keymappings
" Turn off highlight search
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
" toggle line numbers
nnoremap \tn :set invnumber number?<CR>
nmap <F3> \tn
imap <F3> <C-O>\tn
" Set shortkeys for paste, so several lines can be pasted without indentation problems
set paste
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>
" <C-a> redo paste properly
inoremap <silent> <C-a> <ESC>u:set paste<CR>.:set nopaste<CR>gi
" Toggle word wrap
nnoremap \tw :set invwrap wrap?<CR>
nmap <F7> \tw
imap <F7> <C-O>\tw
" Toggle current line highlighting (because it's pretty slow)
nnoremap \tc :set invcul cul?<CR>
nmap <F8> \tc
imap <F8> <C-O>\tc
" Toggle spellchecking
nnoremap \ts :set invspell spell?<CR>
nmap <F9> \ts
imap <F9> <C-O>\ts

" Eclipse-like parenthesis handling
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap (* (*  *)<Left><Left><Left>
" Same for quotes, except in vim files (where " is comment, obviously)
au BufRead if &ft != 'vim' | inoremap " ""<Left> | endif
" 'Escapes' for the above
inoremap (( (
inoremap () ()
inoremap {{ {
inoremap "" ""
inoremap {} {}

inoremap <F12> :w !detex \| wc -w<CR>

" Filetype-specific autocommands.
" The different FileTypes can be found in /usr/share/vim/vimcurrent/filetype.vim
filetype on         " detect filetypes
augroup vimrc_filetype
	autocmd!
	autocmd BufNewFile,BufRead *.io setf io
	"autocmd FileType    make        set softtabstop=0 noexpandtab shiftwidth=8 " Makefiles need real tabs
	autocmd FileType    helpfile    nnoremap <buffer><cr> <c-]> " Enter selects subject
	autocmd FileType    helpfile    nnoremap <buffer><bs> <c-T> " Backspace to go back
	autocmd FileType    tex         inoremap { {}<Left>
	" Highlight characters exceeding 80:
	hi LineTooLong ctermfg=red ctermbg=darkgray guibg=LightYellow
	autocmd FileType    c,java      match LineTooLong /\%>80v.\+/
	" Boilerplate
	autocmd FileType    java        abbr psvm public static void main(String[] args) {
	autocmd FileType    java        abbr sop System.out.println
	" Comment lines with - (TODO replace this with http://github.com/scrooloose/nerdcommenter )
	autocmd FileType    c,cpp,java,php  map - :s/^/\/\//<CR>:nohlsearch<CR>
	autocmd FileType    c,cpp,java,php  inoremap {  {<CR>}<Esc>O
	autocmd FileType    vim         map - :s/^/\"/<CR>:nohlsearch<CR>
	autocmd FileType    ruby        map - :s/^/#/<CR>:nohlsearch<CR>
	autocmd FileType    xdefaults   map - :s/^/!/<CR>:nohlsearch<CR>
	autocmd FileType    lisp,scheme map - :s/^/;/<CR>:nohlsearch<CR>
	autocmd FileType    scheme,lisp set lisp
        " HTML/XML auto close
        autocmd FileType    html,xml,xsl,php source ~/.vim/scripts/closetag.vim
        
	" Automatically chmod +x Shell and Perl scripts
	autocmd BufWritePost   *.sh     !chmod +x %
	autocmd BufWritePost   *.pl     !chmod +x %
	" Automatically source
	autocmd BufWritePost   ~/.vimrc  :source %
	autocmd BufWritePost   ~/.bashrc :!source %
augroup END

" Uncomment lines with _ (one rule for all languages)
map _ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" directory listing filter
let g:netrw_list_hide= '.*\.pyc$\|.*\.swp$'

