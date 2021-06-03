let mapleader = " "
call plug#begin()

Plug 'lepture/vim-jinja'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pangloss/vim-javascript'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/completion-treesitter'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'mhinz/vim-startify'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'

Plug 'dpretet/vim-leader-mapper'

Plug 'ludovicchabant/vim-gutentags'

Plug 'troydm/zoomwintab.vim'

Plug 'scrooloose/syntastic'

Plug 'morhetz/gruvbox'

Plug 'codota/tabnine-vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'terryma/vim-multiple-cursors'

Plug 'vim-test/vim-test'

Plug 'vimwiki/vimwiki'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'preservim/tagbar'

Plug 'ap/vim-css-color'

call plug#end()

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tagbar#flags = 's'
let g:airline#extensions#tagbar#flags = 'p'

lua require('telescope').load_extension('media_files')
lua require('telescope').load_extension('fzy_native')

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" Configure the completion chains
let g:completion_chain_complete_list = {
            \'default' : {
            \    'default' : [
            \        {'complete_items' : ['lsp', 'snippet']},
            \        {'mode' : 'file'}
            \    ],
            \    'comment' : [],
            \    'string' : []
            \    },
            \'vim' : [
            \    {'complete_items': ['snippet']},
            \    {'mode' : 'cmd'}
            \    ],
            \'c' : [
            \    {'complete_items': ['ts']}
            \    ],
            \'python' : [
            \    {'complete_items': ['ts']}
            \    ],
            \'lua' : [
            \    {'complete_items': ['ts']}
            \    ],
            \}

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.perl = {
  install_info = {
    url = "~/tree-sitter-perl", -- local path or git repo
    files = {"src/parser.c"}
  },
  filetype = "pm", -- if filetype does not agrees with parser name
  used_by = {"pl", "t"} -- additional filetypes that use this parser
}
EOF

lua <<EOF
require'telescope'.setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
    }
  },
}
EOF

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_enable_snippet = 'Neosnippet'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_perl_checker = 1
let g:syntastic_enable_raku_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_raku_checkers = ['raku']

set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_enable_auto_popup = 0

"map <c-p> to manually trigger completion
imap <silent> <c-p> <Plug>(completion_trigger)


" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap s <Plug>(vsnip-select-text)
xmap s <Plug>(vsnip-select-text)
nmap S <Plug>(vsnip-cut-text)
xmap S <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']


nmap <silent> <leader>fd :tabe $MYVIMRC<CR>
" Find files using Telescope command-line sugar.
nnoremap <silent> <leader>ff  <cmd>Telescope find_files<cr>
"nnoremap <leader>fg  <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>fb  <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>fh  <cmd>Telescope help_tags<cr>
"nnoremap <leader>fp  <cmd>Telescope project<cr>
nnoremap <silent> <leader>fgc <cmd>Telescope git_commits <cr>
nnoremap <silent> <leader>fgb <cmd>Telescope git_branches <cr>

vmap <Enter> <Plug>(EasyAlign)
nmap ga      <Plug>(EasyAlign)

set relativenumber
set nu

let file_menu = {'name': "File",
     \'d':  [":tabe $MYVIMRC",        "tabe vimrc"],
     \'f':  [":Telescope find_files", "find files"],
     \'b':  [":Telescope bufers",     "buffers"],
     \'h':  [":Telescope help_tags",  "help"],
     \'nt': [":NERDTreeToggleVCS",    "nerd tree"],
\}

let git_menu = {'name': "Git",
     \'gg': [":GitGutterToggle",                        "GitGutter"],
     \'sc': [":Telescope git_commits",                  "list commits"],
     \'b':  [":Telescope git_branches",                 "branches"],
     \'s':  [":GitGutterStageHunk",                     "stage hunk"],
     \'c':  [":Git commit",                             "commit"],
     \'p':  [":Git push",                               "push"],
     \'st': [":Git",                                    "status"],
     \'qf': [":command! Gqf GitGutterQuickFix | copen", "quickfix changes"],
     \']':  [":GitGutterNextHunk",                      "next hunk"],
     \'[':  [":GitGutterPrevHunk",                      "previous hunk"],
\}

let run_menu = {'name': "Run",
     \'p':  [":!perl %", "Run perl"],
     \'r':  [":!raku %", "Run raku"],
     \'js': [":!node %", "Run javascript"],
\}

let g:leaderMenu = {'name':  "Main Menu",
     \'f':   [file_menu,                                    "File Menu"],
     \'g':   [git_menu,                                     "Git Menu"],
     \'r':   [run_menu,                                     "Run Menu"],
     \'s':   [":SyntasticToggleMode",                       "Toggle syntastic"],
     \'njk': [":set filetype=jinja | :SyntasticToggleMode", "Set NJK filetype"],
 \}

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader  "\<Space>"
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

colorscheme gruvbox

" Use persistent history.
if !isdirectory("/Users/fernando/.config/vim-undo-dir")
    call mkdir("/Users/fernando/.config/vim-undo-dir", "", 0700)
endif
set undodir=/Users/fernando/.config/vim-undo-dir
set undofile

autocmd BufRead,BufNewFile /Volumes/Code/humanstate/payprop/payprop_www/src/* set syntax=jinja.html | SyntasticToggleMode

set mouse=a

let g:startify_session_autoload = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special = 0

autocmd FileType gitcommit setlocal spell

set list listchars=tab:│\ ,nbsp:␣,trail:☒,extends:▶,precedes:◀,eol:§,space:ᐧ

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
