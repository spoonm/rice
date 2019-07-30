set nocompatible
set background=dark
set smartindent noexpandtab tabstop=4 shiftwidth=4 textwidth=80
set scrolloff=15 sidescrolloff=5 updatetime=750
set laststatus=1 fo+=t
set ttimeoutlen=0
set incsearch ruler nohlsearch splitbelow splitright number rnu
set fillchars+=vert:│,fold:\  backspace=indent,eol,start
set foldmethod=marker ignorecase smartcase
set listchars=tab:⏵\ ,trail:· list
set cursorline

filetype plugin on
syntax on

" {{{ colors
highlight Pmenu         ctermfg=7  ctermbg=0
highlight PmenuSel      ctermfg=15 ctermbg=8
highlight Todo          ctermfg=15 ctermbg=7
highlight TabLineFill   term=none  cterm=none ctermbg=none
highlight TabLine       term=none  cterm=none ctermbg=none
highlight TabLineSel    term=none  cterm=none ctermbg=8
highlight VertSplit     term=bold  cterm=none ctermfg=7  ctermbg=0
highlight StatusLine    term=bold  cterm=bold ctermfg=0  ctermbg=7
highlight StatusLineNC  term=bold  cterm=none ctermfg=15 ctermbg=0
highlight Folded        ctermfg=15 ctermbg=0
highlight CursorLine    cterm=none ctermbg=0
highlight SignColumn    ctermbg=none
" }}}
" {{{ plugins
call plug#begin('~/.local/share/nvim/plugged')

	" {{{ tpope plugins (eunuch, unimpaired, etc.)
	Plug 'tpope/vim-eunuch'                " unix commands
	Plug 'tpope/vim-unimpaired'            " some weird operations
	Plug 'tpope/vim-repeat'                " better . repetition
	Plug 'tpope/vim-surround'              " surrounding characters
	Plug 'tpope/vim-fugitive'              " git wrapper
	Plug 'tpope/vim-commentary'            " comment stuff out and whatnot
	" }}}
	" {{{ NERDTree
	Plug 'scrooloose/nerdtree'             " the NERDtree

		let g:NERDTreeDirArrowExpandable = '+'
		let g:NERDTreeDirArrowCollapsible = '-'
		let g:NERDTreeMinimalUI = 1

	Plug 'Xuyuanp/nerdtree-git-plugin'     " NERDtree git flags
	" }}}
	" {{{ ALE
	Plug 'w0rp/ale'

		let g:ale_enabled = 0
		let g:ale_sign_column_always = 1
		let g:ale_linters = {
		\	'c': ['clang'],
		\	'haskell': []
		\}
		let g:ale_c_clang_options = '-std=c99 -Wall'
		let g:ale_lint_on_save = 1
		" let g:ale_lint_on_text_changed = 'always'
		let g:ale_lint_delay = 500

		nmap     <silent> <C-k> <Plug>(ale_previous_wrap)
		nmap     <silent> <C-j> <Plug>(ale_next_wrap)

		highlight ALEWarningSign ctermbg=none ctermfg=12
		highlight ALEErrorSign   ctermbg=1    ctermfg=15
	" }}}

	" Plug 'wikitopian/hardmode'             " vim hard mode
	" Plug 'thinca/vim-localrc'              " directory specific vimrc
	Plug 'keith/tmux.vim'                  " .tmux.conf syntax highlighting
	" Plug 'aklt/plantuml-syntax'            " plantuml syntax highlighting
	Plug 'godlygeek/tabular'               " aligning text
	Plug 'plasticboy/vim-markdown'         " markdown stuff

		let g:vim_markdown_folding_disabled = 0

	Plug 'junegunn/goyo.vim'               " make text readable
	Plug 'rhysd/vim-grammarous'            " self explanatory
	Plug 'ntpeters/vim-better-whitespace'  " self explanatory

		au BufRead * EnableStripWhitespaceOnSave

	Plug 'aperezdc/vim-template'           " pattern-case templates

		let g:templates_no_autocmd = 1
		let g:templates_directory = "/home/spoonm/documents/templates"

	Plug 'iamcco/markdown-preview.vim'     " markdown preview

		let g:mkdp_path_to_chrome = "qutebrowser --target window"
		let g:mkdp_auto_close = 1

	Plug 'iamcco/mathjax-support-for-mkdp' " mathjax support
	Plug 'xuhdev/vim-latex-live-preview'   " self explanatory
		let g:livepreview_previewer = 'zathura'
		let g:livepreview_engine = 'pandoc'

	Plug 'lervag/vimtex' " LaTeX stuff
	" {{{ deoplete
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

		let g:deoplete#enable_at_startup = 1
		let g:deoplete#enable_smart_case = 1
		let g:deoplete#sources#syntax#min_pattern_length = 3


		" {{{ mappings
		inoremap <expr><C-g>    deoplete#undo_completion()
		inoremap <expr><C-l>    deoplete#complete_common_string()
		inoremap <expr><TAB>    pumvisible() ? "\<C-n>" : "\<TAB>"
		inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
		inoremap <expr><C-h>    deoplete#smart_close_popup()."\<C-h>"
		inoremap <expr><BS>     deoplete#smart_close_popup()."\<C-h>"
		" }}}
		"{{{ autocmd
		au BufWrite * pclose!
		"}}}

	" {{{ deoplete-go
	Plug 'zchee/deoplete-go', { 'do': 'make' }

		let g:deoplete#sources#go#gocode_binary = '/home/spoonm/.go/bin/gocode'
		let g:deoplete#sources#go#package_dot = 1
		let g:deoplete#sources#go#cgo = 1
		let g:deoplete#sources#go#cgo#libclang_path = '/usr/lib/libclang.so'
	" }}}
	" {{{ clang_complete
	Plug 'Rip-Rip/clang_complete', { 'do': 'make' }

		let g:clang_library_path = '/usr/lib/libclang.so'
		let g:clang_make_default_keymappings = 0
	" }}}
	" {{{ vim-javacomplete2
	Plug 'artur-shaik/vim-javacomplete2'

		autocmd FileType java setlocal omnifunc=javacomplete#Complete
		nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
		imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
	" }}}

	Plug 'zchee/deoplete-jedi'
	Plug 'zchee/deoplete-zsh'

	Plug 'Shougo/neco-syntax'
	Plug 'Shougo/neco-vim'
	Plug 'Shougo/neoinclude.vim'
	Plug 'Shougo/neopairs.vim'
	" }}}

call plug#end()
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#option('ignore_sources', {'_':['buffer']})
" }}}
" {{{ mappings
" close/open current fold
nnoremap <Space> za

" going to the first window (usually NERDTree)
nnoremap <C-t> 1<C-w>w
inoremap <C-t> 1<C-w>w

" exit the terminal window with Esc
tnoremap <Esc> <C-\><C-n>
" }}}
" {{{ character shortcuts
inoremap emd<Space> —<Space>
" }}}

augroup neomutt"{{{
	au!
	au BufRead /tmp/neomutt-* set tw=72 noautoindent filetype=mail
augroup END"}}}
augroup html"{{{
	au!
	au FileType html inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
	au FileType html inoremap ç1 <h1></h1><Esc>F1T>i
	au FileType html inoremap çp <p></p><Enter><Enter><++><Esc>2ki
	au FileType html inoremap çb <b></b><Space><++><Esc>FbT>i
augroup END"}}}
augroup markdown "{{{
	au!
" 	au FileType markdown inoremap $$ $$\begin{equation}<Enter>\end{equation}$$<Enter><Enter>++<Esc>2kO
	au FileType markdown set foldlevelstart=99 foldlevel=3

	au FileType markdown inoremap jj <Esc>/++<Enter>"_c2l
	au FileType markdown inoremap kk <Esc>?++<Enter>"_c2l
	" au FileType markdown inoremap çi ** ++<Esc>3hi
	" au FileType markdown inoremap çb **** ++<Esc>4hi
	au FileType markdown inoremap al$ $$\begin{aligned}<Enter>\end{aligned}$$<Enter><Enter>++<Esc>2kO
	au FileType markdown inoremap çint \int_{}^{++} ++<Esc>8hi
	au FileType markdown inoremap çlim \lim_{} ++<Esc>3hi
	au FileType markdown inoremap çsum \sum_{}^{++} ++<Esc>8hi
	au FileType markdown inoremap çfr \frac{}{++} ++<Esc>7hi
	au FileType markdown inoremap çif \infty
	au FileType markdown inoremap forall \forall
	au FileType markdown inoremap exists \exists
augroup END"}}}

augroup common " {{{
	au BufWritePost * if &makeprg != 'make' | make | endif
augroup END " }}}

" vim: set ts=2 sw=2 noet foldmethod=marker :
