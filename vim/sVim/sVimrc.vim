" Gist ID is the hash at the last part of the url when viewing the gist.
" Gist must be public so sVim can sync it.

" setting
set smoothscroll
let fullpagescrollpercent = 100
let homeurl = "favorites://"
let newtaburl = "favorites://"
let blacklists = ["*://github.com/*"]

" mapping
let mapleader = ";"
unmapAll " disable default sVim mappings

" buffer
map "j" scrollDown
map "k" scrollUp
map "h" scrollLeft
map "l" scrollRight
map "0" scrollToLeft
map "$" scrollToRight
map "g g" scrollToTop
map "shift+g" scrollToBottom

" pane
map "ctrl+[" scrollFullPageUp
map "ctrl+]" scrollFullPageDown
map "ctrl+shift+[" scrollPageUp
map "ctrl+shift+]" scrollPageDown

" tab
map "<Leader> h" previousTab
map "<Leader> l" nextTab

" other
map "<Leader> ," showsVimrc
map "i" goToInput

" disabled
" let fullpagescrollpercent = 100
" let lastactivetablimit = 50;
" let lastclosedtablimit = 50;
" let scrollduration = 25
" let scrollstep = 65
" let zoomstep = 15
" let hintcharacters = "1234567890";
" let nextpagetextpatterns = ["Next"]
" let prevpagetextpatterns = ["Prev(ious)?"]
" map "<Leader> h" closeTabLeft
" map "<Leader> l" closeTabRight
" map "space" scrollFullPageDown
" map "<Leader> n" newTab
" map "<Leader> n" gotoNextPage
" map "<Leader> p" gotoPrevPage
