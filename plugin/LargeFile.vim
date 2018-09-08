" LargeFile: Sets up an autocmd to make editing large files work with celerity
"   Author:		Charles E. Campbell
"   Date:		Nov 25, 2013
"   Version:	5
"   Copyright:	see :help LargeFile-copyright
" GetLatestVimScripts: 1506 1 :AutoInstall: LargeFile.vim
"DechoRemOn

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_LargeFile") || &cp
 finish
endif
let g:loaded_LargeFile = "v5"

" ---------------------------------------------------------------------
"  Options: {{{1
if !exists("g:LargeFile")
 let g:LargeFile= 5	" in megabytes
endif

" ---------------------------------------------------------------------
"  LargeFile Autocmd: {{{1
" for large files: turns undo, syntax highlighting, undo off etc
" (based on vimtip#611)
augroup LargeFile
 au!
 au BufReadPost	* call <SID>LargeFile(0,expand("<afile>"))
augroup END

" ---------------------------------------------------------------------
" s:LargeFile: {{{2
fun! s:LargeFile(force,fname)
"  call Dfunc("s:LargeFile(force=".a:force." fname<".a:fname.">) buf#".bufnr("%")."<".bufname("%")."> g:LargeFile=".g:LargeFile)
    let fsz= getfsize(a:fname)
    if a:force || fsz >= g:LargeFile*1024*1024 || fsz <= -2
        syn clear
        setlocal filetype=
        setlocal noswf bh=unload fdm=manual nofen cpt-=wbuU nobk nowb ul=-1 nowrap
    endif
endfun

