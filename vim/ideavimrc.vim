let mapleader = '-'

set hlsearch
set scrolloff=3
set smartcase
set showmode
set history=1000
set surround " activate the vim-surround key bindings"

" maps
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h

nnoremap gh gT
nnoremap gl gt

" onoremap iv i[
" onoremap av a[

" easy window navigation
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap gr gT
nnoremap <c-s-tab> gT
nnoremap <c-tab> gt
nnoremap <C-w>x :vs<CR>:q<C-w>l
nnoremap <C-w>v :vs<CR>:q<C-w>j

nnoremap <C-u> :action FindUsages<cr>
nnoremap <C-S-u> :action HighlightUsagesInFile<cr>

" code refactoring
nnoremap cre :action RenameElement<cr>
nnoremap cs :action ChangeSignature<cr>
nnoremap cts :action ChangeTypeSignature<cr>

" unimpaired mappings
nnoremap [<Space> O<esc>j
nnoremap ]<Space> o<esc>k
nnoremap [m :action MethodUp<cr>
nnoremap ]m :action MethodDown<cr>
nnoremap [c :action VcsShowPrevChangeMarker<cr>
nnoremap ]c :action VcsShowNextChangeMarker<cr>

nnoremap <C-p> :action GotoFile<CR>
nnoremap <C-S-p> :action GotoClass<CR>
nnoremap <C-s> :action GotoSymbol<CR>
nnoremap <C-a> :action GotoAction<CR>

nnoremap K :action GotoDeclaration<CR>
nnoremap gK :action GotoTypeDeclaration<CR>
nnoremap gje :action GoToErrorGroup<CR>
nnoremap gji :action GotoImplementation<CR>
nnoremap gs :action GotoSuperMethod<CR>
nnoremap gjt :action GotoTest<CR>

nnoremap gb0 :action GotoBookmark0 <CR>
nnoremap gb1 :action GotoBookmark1<CR>
nnoremap gb2 :action GotoBookmark2<CR>
nnoremap gb3 :action GotoBookmark3<CR>
nnoremap gb4 :action GotoBookmark4<CR>
nnoremap gb5 :action GotoBookmark5<CR>
nnoremap gb6 :action GotoBookmark6<CR>
nnoremap gb7 :action GotoBookmark7<CR>
nnoremap gb8 :action GotoBookmark8<CR>
nnoremap gb9 :action GotoBookmark9<CR>
nnoremap gjl :action GoToLinkTarget<CR>

nnoremap gnb :action GotoNextBookmark<CR>
nnoremap gne :action GotoNextError<CR>
nnoremap gnx :action GotoNextIncompletePropertyAction<CR>
nnoremap gpb :action GotoPreviousBookmark<CR>
nnoremap gep :action GotoPreviousError<CR>

" will be replaced as soon as onoremap works
nnoremap civ ci[
nnoremap div di[
nnoremap yiv yi[
nnoremap cav ca[
nnoremap dav da[
nnoremap yav ya[

" easy system clipboard copy/paste
noremap "+y "*y
noremap "+Y "*Y
noremap "+p "*p
noremap "+P "*P
noremap <C-S-c> "*y
noremap <C-S-v> "*P

" built-in navigation to navigated items works better
nnoremap <c-o> :action Back<cr>
nnoremap <c-i> :action Forward<cr>
" but preserve ideavim defaults
nnoremap <C-S-o> <c-o>
nnoremap <C-S-i> <c-i>

" generate
nnoremap <leader>gt :action GenerateTestMethod<CR>
nnoremap <leader>gs :action GenerateSetUpMethod<CR>
nnoremap <leader>gG :action GenerateGetter<CR>
nnoremap <leader>gS :action GenerateSetter<CR>
nnoremap <leader>ga :action GenerateGetterAndSetter<CR>
nnoremap <leader>ge :action GenerateEquals<CR>
nnoremap <leader>gc :action GenerateConstructor<CR>
nnoremap <leader>G :action Generate<CR>

" enter newlines
nnoremap <CR> :action EditorEnter<CR>
inoremap <CR> <C-o>:action EditorEnter<CR>

" windows
nnoremap gwm :action ActivateEventLogToolWindow<CR>
nnoremap gwg :action ActivateGradleToolWindow<CR>
nnoremap gwd :action ActivateDebugToolWindow<CR>
nnoremap gwr :action ActivateRunToolWindow<CR>
nnoremap gwb :action ViewBreakpoints<CR>

" imaps
inoremap <C-A-c> {@code }<C-o>h
inoremap <C-A-l> {@link }<C-o>h
inoremap <C-S-k> <C-o>k
inoremap <C-S-j> <C-o>j
inoremap <C-S-l> <C-o>l
inoremap <C-S-h> <C-o>h
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

nnoremap gjK :action QuickJavaDoc<CR>
nnoremap ]] :action MethodDown<CR>
nnoremap [[ :action MethodUp<CR>

nnoremap <Space> :nohl<CR>
nnoremap <leader>R :action Rerun<CR>
nnoremap <leader>rt :action RerunTests<CR>
nnoremap <leader>rf :action RerunFailedTests<CR>

nnoremap <leader>go :action OverrideMethods<CR>
nnoremap <leader>d 0w:action ShowIntentionActions<CR>

nnoremap <leader>gn :action NewClass<CR>

" debugger
nnoremap i :ForceStepInto
nnoremap o :ForceStepOver
nnoremap p :Stepout
nnoremap n :action ToggleLineBreakpoint<CR>
nnoremap m :action ToggleMethodBreakpoint<CR>
nnoremap <CR> :action Resume<CR>

" templates
inoremap <C-k> <C-o>:action NextTemplateVariable<CR>
inoremap <C-j> <C-o>:action PreviousTemplateVariable<CR>
