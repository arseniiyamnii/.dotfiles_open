execute pathogen#infect()



"CONTENT
"statusline_edit
"colors_edit
"edit_built_in_functions
"plugins_install
"plugins_settings



"statusline_edit
"
"
let g:gitrepo = trim(system("git branchname"))
function ProjectName()
	return substitute(getcwd(), '^.*/', '', '')
endfunction

function BranchName()
	return g:gitrepo
endfunction



set laststatus=2
set statusline= 
set statusline+=%#LineNr#

set statusline+=%{ProjectName()}
set statusline+=%#LineNr#
set statusline+=\ 
set statusline+=[%{BranchName()}]
set statusline+=\ %f
set statusline+=\ 
"set statusline+=%{FugitiveStatusline()}
"set statusline+=%m
set statusline+=%=					"go to left side
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]

set statusline+=\ %l/%L
set statusline+=\(%p%%)
set statusline +=\ %c             "total lines
set statusline+=\ 


"colors_edit
"
syntax on
colorscheme default
colorscheme monokai

"edit_built_in_functions
"
set noequalalways
filetype plugin on
set number
set tabstop=4
set shiftwidth=4
set cursorline 
set list lcs=tab:\|\ 
set smartindent
set breakindent
set colorcolumn=80
"set textwidth=80
set splitright
set foldmethod=indent
set foldlevelstart=20
set noexpandtab

"set cpoptions+=&
augroup remember_folds
  autocmd!
  if @% != ""
	  autocmd BufWinLeave * mkview
	  "autocmd BufWinLeave * preserve

  endif
  autocmd BufWinEnter * silent! loadview
augroup END
set ignorecase
set undofile
set undodir=~/.vim/undodir/
set undolevels=100000         " How many undos
set undoreload=100000        " number of lines to save for undo
inoremap <Space> <Space><C-g>u
set shortmess-=S
set showcmd

"Keybindings
cnoreabbrev W wqa
cnoreabbrev Q qa
cnoreabbrev utt UndotreeToggle 
"cnoreabbrev Q echo RecoveryExit()
"function! RecoveryExit()
	"set cpoptions+=&
	"execute ':preserve'
	"execute 'qa!'
"endfunction
cnoreabbrev S source ~/.vimrc
cnoreabbrev ms vnew
cnoreabbrev mt tabe
function! Gfc()
	let fullpath = fnamemodify(resolve(expand('%')), ':h')
	let file = fnamemodify(resolve(expand('%')), ':t')
	let tempdir = getcwd()
	execute ':w'
	execute 'cd' fnameescape(fullpath)
	execute '!git add' fnameescape(file)
	execute '!git commit' fnameescape(file)
	execute 'cd' fnameescape(tempdir)
endfunction

cnoreabbrev gfc echo Gfc()
cnoreabbrev wg echo Gfc()
function! FastTest()
	execute ':w'
	execute '!./fasttest.sh'
endfunction
cnoreabbrev wt echo FastTest()
cnoreabbrev gst !git status

function! S2T(num)
	execute ":set tabstop=".a:num
	execute ":set shiftwidth=".a:num
	set noexpandtab
	execute ':%retab!'
endfunction
cnoreabbrev s2t S2T

function! CTW(num)
	execute ":set tabstop=".a:num
	execute ":set shiftwidth=".a:num
endfunction
cnoreabbrev ctw CTW

function! T2S()
	set expandtab
	execute ":%retab!"
endfunction
command! -nargs=1 S2T call S2T(<args>)
command! -nargs=1 CTW call CTW(<args>)
command! T2S call T2S()

cnoreabbrev t2s T2S

cnoreabbrev showplugs !ls ~/.vim/bundle
function! ToffP(name)
	let l:oldname = "~/.vim/bundle/".a:name
	let l:newname = l:oldname."~"
	execute ":!mv ".l:oldname." ".l:newname
	"execute ":source ~/.vimrc"
endfunction
command! -nargs=1 -complete=customlist,ListBundlesOff ToffP call ToffP(<args>) | source ~/.vimrc
fun ListBundlesOff(A,L,P)
	let l:bundles=systemlist('ls ~/.vim/bundle')
	for i in l:bundles
		if stridx(i,"~") >= 0
			let l:trashes=remove(l:bundles, index(l:bundles,i))
		endif
	endfor
	for i in l:bundles
		let l:trashes=remove(l:bundles, index(l:bundles,i))
		call insert(l:bundles,'"'.i.'"')
	endfor
	return l:bundles
endfun

function! TonP(name)
	let l:oldname = "~/.vim/bundle/".a:name
	let l:newname = l:oldname."~"
	execute ":!mv ".l:newname." ".l:oldname
	"execute ":source ~/.vimrc"
endfunction
command! -nargs=1 -complete=customlist,ListBundlesOn TonP call TonP(<args>) | source ~/.vimrc
fun ListBundlesOn(A,L,P)
	let l:bundles=systemlist('ls ~/.vim/bundle')
	for i in l:bundles
		if stridx(i,"~") < 0
			let l:trashes=remove(l:bundles, index(l:bundles,i))
		endif
	endfor
	for i in l:bundles
		let l:trashes=remove(l:bundles, index(l:bundles,i))
		let l:editing = i[:-2]
		call insert(l:bundles,i[:-2])
	endfor
	for i in l:bundles
		let l:trashes=remove(l:bundles, index(l:bundles,i))
		call insert(l:bundles,'"'.i.'"')
	endfor
	return l:bundles
endfun
function! SoffP()
	let l:bundles=systemlist('ls ~/.vim/bundle')
	for i in l:bundles
		if stridx(i,"~") < 0
			let l:trashes=remove(l:bundles, index(l:bundles,i))
		endif
	endfor
	for i in l:bundles
		let l:trashes=remove(l:bundles, index(l:bundles,i))
		let l:editing = i[:-2]
		call insert(l:bundles,i[:-2])
	endfor
	let l:echomessage = "\n"
	for i in l:bundles
		let l:echomessage = l:echomessage.i."\n"
	endfor
	echo l:echomessage
endfunction
command! SoffP call SoffP()
function! SonP()
	let l:bundles=systemlist('ls ~/.vim/bundle')
	for i in l:bundles
		if stridx(i,"~") >= 0
			let l:trashes=remove(l:bundles, index(l:bundles,i))
		endif
	endfor
	let l:echomessage = "\n"
	for i in l:bundles
		let l:echomessage = l:echomessage.i."\n"
	endfor
	echo l:echomessage
endfunction
command! SonP call SonP()
function! InstallP(name)
	let tempdir = getcwd()
	execute 'cd ~/.vim/bundle'
	execute '!git submodule add -f '.a:name 
	execute 'cd' fnameescape(tempdir)
endfunction
command! -nargs=1 InstallP call InstallP(<args>) | source ~/.vimrc


function! GetLink()
"https://gitlab.com/eyecon/vavada-admin/-/blob/yamnii-refactor-ci/.gitlab/ci/deploy.yml#L6
	let curLine = line(".")
	let projectline = system("git remote show origin | grep URL | head -n 1 | awk -F'@' '{print $2}'")
	let projectdomain = split(projectline, "@")[0]
	let projectserver = split(projectdomain, ":")[0]
	let projectserver2 = split(projectdomain, ":")[1]
	let projectname = projectserver2[:-6]
	"let command = "if [[ ! $(git ls-remote --heads $(git remote show origin | grep URL | head -n 1 | awk -F' ' '{print $4}') $(git rev-parse --abbrev-ref HEAD)) ]]; then echo $(git show-branch | grep '*' | awk '{ print $NF }' | "
	"let command = command.'sed "s/'
	"let command = command."'//g"
	"let command = command.'" | head -n 1) ;else echo $(git rev-parse --abbrev-ref HEAD); fi0'
	let currentbranch = trim(system("if [[ ! $(git isre) ]]; then echo $(git parent) ;else echo $(git branchname); fi"))
	let filepath = trim(system("git rev-parse --show-prefix")).@%
	if projectserver == 'gitlab.com'
		let lineurl = "https://".projectserver."/".projectname."/-/blob/".currentbranch."/".filepath."#L".curLine
	else
		let lineurl = "dont know server"
	endif
	echom lineurl
	call system("if [[ $(command -v xclip) ]]; then echo ".lineurl." | xclip -sel clip; else echo 'install xclip'; fi")
endfunction
command Getl call GetLink()
cnoreabbrev getl Getl
cnoreabbrev fzf FZF
cnoreabbrev r- vertical resize -10
cnoreabbrev r+ vertical resize +10

function! ShowChanges()
	let curLine=trim(getline('.'))
	let curLine=substitute(l:curLine, '\/', '\\/\\/', "g")
	let filepath = trim(system("git rev-parse --show-prefix")).@%
	execute "!git --no-pager log --follow -p -- ".@%." | grep -E '^[Author|\+|\-]' > /tmp/gitlog && vim -c ".'"'.curLine.'"'." /tmp/gitlog && rm /tmp/gitlog"
endfunction
command Lineh call ShowChanges()

cnoreabbrev filehist !git log-search @%
" save and commit
"plugins_install
"
"
call plug#begin('~/.vim/plugged')
"basic plugins
"
"Plug 'preservim/nerdtree'
"Plug 'preservim/nerdcommenter'
"Plug 'embear/vim-localvimrc'
"Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-fugitive'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'chrisbra/recover.vim' "need replace with custom function
"Plug 'mbbill/undotree'
"Plug 'sjl/gundo.vim'
"Plugins with hard instalation
"
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "need fzf
"Plug 'junegunn/fzf.vim' "need fzf
"Plug 'dense-analysis/ale' "need indtall linters and fixers
"Plug 'puremourning/vimspector' " need install debuggers
"Plug 'ycm-core/YouCompleteMe' "need unstal dependencies and compile
"Plug 'FredKSchott/CoVim'
"Plug 'ap/vim-css-color'
call plug#end()
"plugins_settings
"
let g:undotree_SetFocusWhenToggle=1
let NERDTreeQuitOnOpen=1

let g:localvimrc_persistent = 2

"ULTISNIPS
"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsEditSplit="vertical"

" FZF autocomplete
"
"imap <c-x><c-f> <plug>(fzf-complete-path)
"inoremap <expr> <c-x><c-f> fzf#vim#complete#path('ag --hidden --ignore .git -g ""')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('find -L')
"inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --hidden --no-ignore --files')

"ALE
"
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\	'javascript': ['eslint'],
\	'css': ['fecs'],
\	'html':['fecs'],
\	'sh':['shfmt'],
\	'yaml':['yamlfix'],
\	'scss':['stylelint'],
\	'python':['autopep8']
\}
let g:ale_linters = {
\	'javascript': ['eslint'],
\	'css': ['fecs'],
\	'html':['fecs'],
\	'sh':['shellcheck'],
\	'gitcommit':['gitlint'],
\	'yaml':['yamllint'],
\	'python':['flake8'],
\	'scss':['stylelint']
\}

"Vim debugger
"
let g:vimspector_enable_mappings = 'HUMAN'

let g:terraform_align=1
let g:terraform_fold_sections=1
"autocmd BufEnter *.tf* colorscheme icansee
"set runtimepath-=~/.vim/bundle/vim-css-color
"set runtimepath-=~/.vim/bundle/vim-css-color/after
