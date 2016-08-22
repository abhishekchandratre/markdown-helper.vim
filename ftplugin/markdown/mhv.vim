" Vim markdown plugin for converting simple text to markdown.
" Maintainer : Abhishek Chandratre <abhishek.chandratre@gmail.com>
" License : This plugin is placed under PUBLIC domain.

if exists("g:loaded_mhv")
	finish
endif
let g:loaded_mhv = 1


function s:InsertHeader(header_tag)
	let l:save_cursor = getcurpos()
	let l:current_line = getline('.')
	let l:cur_line_length = strlen(l:current_line)
	echom l:cur_line_length

	if a:header_tag == 1
		normal! yyp
		execute "normal! ".l:cur_line_length."r="
	elseif a:header_tag == 2
		normal! yyp
		execute "normal! ".l:cur_line_length."r-"
	elseif a:header_tag == 3
		normal! ^i### 
		normal! A ###
	elseif a:header_tag == 4
		normal! ^i#### 
		normal! A ####
	elseif a:header_tag == 5
		normal! ^i##### 
		normal! A #####
	elseif a:header_tag == 6
		normal! ^i###### 
		normal! A ######
	endif

	call setpos('.', l:save_cursor)
	" keep cursor at new line so that it is easy to navigate
	if a:header_tag < 2
		normal! j
	endif

endfunction

nnoremap <buffer> <localleader>h1 :call <SID>InsertHeader(1)<CR>
nnoremap <buffer> <localleader>h2 :call <SID>InsertHeader(2)<CR>
nnoremap <buffer> <localleader>h3 :call <SID>InsertHeader(3)<CR>
nnoremap <buffer> <localleader>h4 :call <SID>InsertHeader(4)<CR>
nnoremap <buffer> <localleader>h5 :call <SID>InsertHeader(5)<CR>
nnoremap <buffer> <localleader>h6 :call <SID>InsertHeader(6)<CR>
