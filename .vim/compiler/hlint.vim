" Vim Compiler File
" Compiler:	hlint
" Maintainer:   Ian Liu Rodrigues <ian.liu88@gmail.com>
" Last Change:  2020 august 28

if exists("current_compiler")
  finish
endif
let current_compiler = "hlint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=hlint\ %
CompilerSet errorformat=
      \%E%f:%l:%v-%*[0-9]:\ Error:\ %m,
      \%E%f:%l:%v:\ Error:\ %m,
      \%W%f:%l:%v-%*[0-9]:\ Warning:\ %m,
      \%W%f:%l:%v:\ Warning:\ %m,
      \%I%f:%l:%v-%*[0-9]:\ Suggestion:\ %m,
      \%I%f:%l:%v:\ Suggestion:\ %m,
      \%Z

let &cpo = s:cpo_save
unlet s:cpo_save
