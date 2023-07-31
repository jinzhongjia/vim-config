if has('win32')
  let $ROOT_PATH = '~/vimfiles'
else
  let $ROOT_PATH = '~/.vim'
endif

let $ROOT = expand($ROOT_PATH)
let $config_path = expand($ROOT_PATH .. '/vimrc')

" 快捷的配置vim配置的命令
command! -nargs=0 Config :edit $config_path

if !isdirectory($ROOT)
  call mkdir($ROOT, 'p')
endif

let s:dein_base = $ROOT .. '/dein'

if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $ROOT .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  " execute 'set runtimepath^=' .. substitute(
  "       \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
  execute 'set runtimepath+=' .. s:dein_dir
endif

" 执行用户设置

set background=dark

" 设置默认终端
if has("win32")
  if and(executable("nu"), executable("pwsh"))
    if has("gui_running")
      set shell=nu
    else
      set shell=pwsh
    endif
  endif
endif

" 真彩色
if (has("termguicolors"))
    set termguicolors
endif

let mapleader = "\<space>"

" 设置为utf8
set encoding=utf-8
set fileencoding=utf-8

set autochdir

set mouse=a

" 忽略大小写
set ignorecase
set smartcase

" 匹配行号
set showmatch

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set wildmenu

" 开启内置的单词拼写检查
" set spell

set autoindent
set smartindent
set nowrap
set whichwrap="<,>,[,]"
set list
set listchars="space:·,tab:··,eol:↴"

set splitbelow
set splitright

set completeopt="menu,menuone,noselect,noinsert"

set fillchars="eob: ,fold: ,foldopen:,foldsep: ,foldclose:"

set scrolloff=5
set sidescrolloff=5

set colorcolumn=80

set cursorline
" set cursorcolumn

set number
set relativenumber

set shiftround

set ruler

set hlsearch
set incsearch

set autoread

set nobackup
set noswapfile
set noundofile
set nowritebackup

set updatetime=300
set timeoutlen=500

" 注意这里设置字体，不同平台有区别
if has('win32')
  set guifont=Maple_Mono_NF:h16
else
  set guifont=Maple\ Mono\ NF\ 16
endif

" set guioptions-=m
set guioptions-=T
set guioptions-=t
set guioptions-=r
set guioptions-=l
set guioptions-=b 


" 显示行号
set signcolumn=yes

" dein插件管理开始
call dein#begin(s:dein_base)

" 管理dein自己
call dein#add(s:dein_dir)
" dein-ui
call dein#add('wsdjeg/dein-ui.vim')
" dein-command
call dein#add('haya14busa/dein-command.vim')

" 添加fugitive
call dein#add('tpope/vim-fugitive')

" wilder.nvim
call dein#add('gelguy/wilder.nvim')
" To use Python remote plugin features in Vim, can be skipped
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" if !has('win32')
" vim-floaterm
call dein#add('voldikss/vim-floaterm')
" endif

" gruvbox theme support
call dein#add('morhetz/gruvbox')

" vim-airline
call dein#add('vim-airline/vim-airline', {'depends':'vim-airline/vim-airline-themes'})
call dein#add('vim-airline/vim-airline-themes')

" coc.nvim
call dein#add('neoclide/coc.nvim', #{ rev: 'release' })

" asynctasks
call dein#add('skywind3000/asynctasks.vim', {'depends':'skywind3000/asyncrun.vim'})
call dein#add('skywind3000/asyncrun.vim')

call dein#add('tpope/vim-commentary')

" zig.vim
call dein#add('ziglang/zig.vim')

" call dein#add('dstein64/vim-startuptime')

call dein#end()

" 启动时自动安装插件
if dein#check_install()
  call dein#install()
endif

if !executable("rg")
  echo "not found ripgrep"
endif

if !executable("nu")
  echo "not found nu"
endif


" 关闭兼容模式
set nocompatible
set backspace=indent,eol,start

" 开启根据文件名称确定文件类型
filetype indent plugin on

" 开启高亮
if has('syntax')
  syntax on
endif

nmap <silent> <C-s> :w<CR>
imap <silent> <C-s> <ESC>:w<CR>

map <silent> q :q<CR>
map <silent> qq :q!<CR>

map <silent> bd :bdelete<CR>
map <silent> bn :bnext<CR>
map <silent> bp :bprevious<CR>

map <silent> sv :vsplit<CR>
map <silent> sh :split<CR>

map <silent> sc :close<CR>
map <silent> so :only<CR>

vmap <silent> <C-c> "+y
vmap <silent> <C-x> "+d
imap <silent> <C-v> <ESC>"+pa

" 主题设置
autocmd vimenter * ++nested colorscheme gruvbox

" setting for wilder
" call wilder#setup({
"       \ 'modes': [':', '/', '?'],
"       \ 'next_key': '<Tab>',
"       \ 'previous_key': '<S-Tab>',
"       \ 'accept_key': '<Down>',
"       \ 'reject_key': '<Up>',
"       \ })
call wilder#setup({'modes': [':', '/', '?']})

" 'highlighter' : applies highlighting to the candidates
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

" setting for airline
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"setting for floaterm, this in only for uinx-like

" if !has('win32')
let g:floaterm_width=0.8
let g:floaterm_height=0.8


let g:floaterm_keymap_new    = '<leader>ft'
let g:floaterm_keymap_prev   = '<leader>fj'
let g:floaterm_keymap_next   = '<leader>fk'
let g:floaterm_keymap_toggle = '<leader>fs'
let g:floaterm_keymap_kill = '<leader>fc'

" endif

" setting zig.vim
let g:zig_fmt_autosave = 0

"setting for asynctasks
let g:asyncrun_open = 6

" setting for coc.nvim

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-marketplace', 'coc-tsserver', 'coc-go', 'coc-spell-checker', 'coc-markdownlint', 'coc-eslint','coc-snippets','coc-sumneko-lua','coc-pairs','coc-lists','coc-docker','coc-zls','coc-highlight','coc-translator','coc-yaml','coc-explorer','coc-clangd','coc-html','coc-rust-analyzer','coc-symbol-line','coc-html-css-support','coc-lightbulb','@yaegassy/coc-pylsp','coc-css','coc-cmake','coc-sh','coc-sql','@yaegassy/coc-volar','@yaegassy/coc-volar-tools','coc-vimlsp','coc-yank','coc-emmet','coc-prettier','coc-toml','coc-xml','coc-calc','coc-typos', 'coc-explorer']

" explorer
nmap <space>e <Cmd>CocCommand explorer<CR>

" 使用tab作为触发补全的功能
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> gj <Plug>(coc-diagnostic-next)
nmap <silent> gk <Plug>(coc-diagnostic-prev)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> gh :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
" nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <CR> <Plug>(coc-range-select)
xmap <silent> <CR> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

nnoremap <silent> <leader>cc  :CocList <cr>
" if !has('win32')
nnoremap <silent> <C-f>  :CocList grep<cr>
nnoremap <silent> <C-p>  :CocList files<cr>
" endif

nmap <silent> <leader>tl <Plug>(coc-translator-p)
vmap <silent> <leader>tl <Plug>(coc-translator-pv)

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
