set completeopt=longest,menuone
set number
set nocompatible                " be iMproved
set autoindent
set smartindent
set showmatch
set ruler
set incsearch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set cindent
set laststatus=2
set t_Co=256



inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
function! RemovePairs()
    let l:line = getline(".")
	let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符
		 
	if index(["(", "[", "{"], l:previous_char) != -1
		let l:original_pos = getpos(".")
		execute "normal %"
		let l:new_pos = getpos(".")
		
		" 如果没有匹配的右括号
		if l:original_pos == l:new_pos
			execute "normal! a\<BS>"
			return
		end
		
		let l:line2	= getline(".")       
		if len(l:line2)	== col(".") 
			" 如果右括号是当前行最后一个字符
			execute "normal! v%xa"
		else
			"如果右括号不是当前行最后一个字符				
			execute	"normal! v%xi"
		end
	else
		execute "normal! a\<BS>"
	end
endfunction
" 用退格键删除一个左括号时同时删除对应的右括号
inoremap <BS> <ESC>:call RemovePairs()<CR>a

" 输入一个字符时，如果下一个字符也是括号，则删除它，避免出现重复字符
function! RemoveNextDoubleChar(char)
	let l:line = getline(".")
	let l:next_char = l:line[col(".")] " 取得当前光标后一个字符      
	if a:char == l:next_char
		execute "normal! l"
	else
		execute "normal! i" . a:char . ""
	end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a


filetype off                    " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Valloric/ListToggle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
filetype plugin indent on

"--+ UltiSnips
let g:UltisnipsExpandTrigger="<C-j>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltisnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:always_use_first_snippet=1

"--+ YouCompleteMe
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
let g:ycm_complete_in_comments = 1 "在注释输入中也能补全
let g:ycm_complete_in_strings = 1 "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0 "注释和字符串中的文字也会被收入补全

"--+ Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

