" Vim syntax file
" Language:	MRV .602 Mission File
" Maintainer:	Tom Harvey <tomh@mrvsys.com>
" Last Change:	today

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif
syn case match

syn keyword mrvTodo	contained TODO FIXME XXX

" TODO still figuring out what to do with these all these keyword categories
" keywords from IDtab
syn keyword mrvParamID SOLOsn CPUsn AUXsn CTDsn
" keywords from Caltab (A/D calibration constants)
syn keyword mrvParamCal Vac0 Vac10 CBat5 CBat6 PBat12 PBat15 Mcur0 Mcur1 Poff Pgain Toff Tgain Soff Sgain 
syn keyword mrvParamBIN BLOK PB1 PB2 AV1 AV2
" keywords from BITab (Acceptable values for Built-In-Test and operation)
syn keyword mrvParamBIT CBmin PBmin VACmn MCmax OILvac
" keywords from STATab (Results recorded during Built-In-Test & cycling)
syn keyword mrvParamSTAT BTcb BTpb BTvac BTdvac BTstat BTDkP0 BTDkP1 BTPsec BTPcur BTSBms DiveNo AbrtCd Phase
" keywords from MISStab
" TODO contained is good
"syn keyword mrvParamMISS PchSec MaxHrs dBarGo ABcymn contained
syn keyword mrvParamMISS PchSec MaxHrs dBarGo ABcymn 
" keywords from MISStab (Specification of multiple duty-cycles)
syn keyword mrvParamMISScycles Cyc0 Cyc1 Cyc2 Ztar0 Ztar1 Ztar2 Zpro0 Zpro1 Zpro2 Tlast0 Tlast1 Tlast2 Rise0 Rise1 Rise2 Fall0 Fall1 Fall2 SAMmn0 SAMmn1 SAMmn2 Nsam0 Nsam1 Nsam2 Pwait0 Pwait1 Pwait2
" keywords from MISStab (Dive Timing info)
syn keyword mrvParamMISSDiveTiming PmpBtm Pmpslo MinRis MxHiP MxSfP GPSsec IRIsec dTadZ dTsdZ mxSeek Nseek STLmin MnSfP Ventsc Ventop SkSLsc AsSLsc PROup Ndives CTDofZ SrfDft SrfLon SrfLat SrfMxN SrfInt BinMod


"TODO get the SBD lines recognized
" SBE lines start %CPtp %CPmd %CPbt  any %CP line is parsed for match
syn cluster mrvParam0  contains=mrvParamID,mrvParamCal,mrvParamBIT,mrvParamSTAT
syn cluster mrvParamGood contains=mrvParamMISS,mrvParamMISScycles,mrvParamMISSDiveTiming,mrvParamBIN
"
"hi def link mrvParamID mrvParam
"hi def link mrvParamCal mrvParam
"hi def link mrvParamBIT mrvParam
"hi def link mrvParamSTAT mrvParam
"hi def link mrvParamMISS mrvParam
"hi def link mrvParamMISScycles mrvParam
"hi def link mrvParamMISSDiveTiming mrvParam
"
"TODO this isn't right--includes and demands whitespace on both sides
syn match   mrvNumber "\s\d\{1,5}\s"
syn match   mrvSetline  "^!...... .*" contains=@mrvParamGood,@mrvParam0,mrvNumber,mrvTodo
syn match   mrvComment  "^#.*" contains=mrvTodo,@mrvParamGood,@mrvParam0
"syn match   mrvComment	"\s#.*"ms=s+1 contains=mrvTodo
syn match   mrvSBD      "^%CP"

"
" TODO we don't want an mrvString
"syn region mrvString	start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
"
"
" TODO this Bad/Good division is not right
hi def link mrvParamID mrvParamBad
hi def link mrvParamCal mrvParamBad
hi def link mrvParamBIT mrvParamBad
hi def link mrvParamSTAT mrvParamBad

hi def link mrvParamMISS mrvParam
hi def link mrvParamMISScycles mrvParam
hi def link mrvParamMISSDiveTiming mrvParam
hi def link mrvParamBIN mrvParam
"
"hi def link mrvParamGood mrvParam

hi def link mrvComment	Comment
hi def link mrvTodo	Todo
hi def link mrvString	String
hi def link mrvParam    Identifier
"hi def link mrvNumber	Number
"
"TODO tmp
"hi def link mrvNumber	Constant
hi def link mrvNumber	Number

hi def link mrvSetline  String
"not used yet
"hi def link mrvError	Error
highlight mrvParamBad ctermfg=Red guifg=Red
let b:current_syntax = "602"

" TODO temporary guides for formatting numbers
if exists("+colorcolumn")
    set colorcolumn=8,14
endif

" vim: ts=8 sw=2
"
