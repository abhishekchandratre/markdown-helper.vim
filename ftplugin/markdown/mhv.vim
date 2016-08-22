" Vim markdown plugin for converting simple text to markdown.
" Maintainer : Abhishek Chandratre <abhishek.chandratre@gmail.com>
" License : This plugin is placed under PUBLIC domain.

if exists("g:loaded_mhv")
	finish
endif
let g:loaded_mhv = 1


function! s:InsertHeader(header_tag)
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

function! s:InsertEmphasisNormal(type)
	" get word under cursor to check for space
	let l:current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
	let l:emphasis_marks = "*"

	" Choose bold for emphasis else default is itlics
	if a:type == 1
		let l:emphasis_marks = "__"
	endif

	" If space go forward and put emphasis on next word
	if l:current_char == " "
		execute "normal! wi".l:emphasis_marks."\<esc>lea".l:emphasis_marks
	else
		execute "normal! viw\<esc>`<i".l:emphasis_marks."\<esc>lea".l:emphasis_marks
	endif
endfunction

function! s:InsertEmphasisVisual(type)
	echom "In Emphasis visual"
	let l:lastSelectionStart = getpos("'<")
	let l:lastSelectionEnd = getpos("'>")
	let l:emphasis_marks = "*"

	" Choose bold for emphasis else default is itlics
	if a:type == 1
		let l:emphasis_marks = "__"
	endif
	"
	" End visual mode
	execute "normal! \<esc>"

	" Check if Visual markers on same line
	let l:shift_needed = 1
	normal `<
	let l:left_marker_line = line('.')
	normal `>
	let l:right_marker_line = line('.')
	if l:left_marker_line != l:right_marker_line
		let l:shift_needed = 0
	endif
	
	" First perform for left end of selection
	normal! `<
	let l:current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
	" If space go forward and put emphasis on next word
	if l:current_char == " "
		execute "normal! wi".l:emphasis_marks
	else
		execute "normal! viw\<esc>`<i".l:emphasis_marks
	endif
	
	" Reset Visual Marker position
	call setpos("'<", l:lastSelectionStart)
	call setpos("'>", l:lastSelectionEnd)

	" Perform for right end of selection
	normal! `>
	if l:shift_needed == 1
		normal! ll
	endif
	let l:current_char = matchstr(getline('.'), '\%' . col('.') . 'c.')
	" If space go forward and put emphasis on next word
	if l:current_char == " "
		execute "normal! bea".l:emphasis_marks
	else
		execute "normal! viw\<esc>`>a".l:emphasis_marks
	endif

	" Reset Visual Marker position
	call setpos("'<", l:lastSelectionStart)
	call setpos("'>", l:lastSelectionEnd)

endfunction

"----------------------------MAPPINGS-------------------------------
nnoremap <buffer> <localleader>h1 :call <SID>InsertHeader(1)<CR>
nnoremap <buffer> <localleader>h2 :call <SID>InsertHeader(2)<CR>
nnoremap <buffer> <localleader>h3 :call <SID>InsertHeader(3)<CR>
nnoremap <buffer> <localleader>h4 :call <SID>InsertHeader(4)<CR>
nnoremap <buffer> <localleader>h5 :call <SID>InsertHeader(5)<CR>
nnoremap <buffer> <localleader>h6 :call <SID>InsertHeader(6)<CR>

nnoremap <buffer> <localleader>b :call <SID>InsertEmphasisNormal(1)<CR>
nnoremap <buffer> <localleader>i :call <SID>InsertEmphasisNormal(2)<CR>
vnoremap <buffer> <localleader>b :<c-u>call <SID>InsertEmphasisVisual(1)<CR>
vnoremap <buffer> <localleader>i :<c-u>call <SID>InsertEmphasisVisual(2)<CR>
