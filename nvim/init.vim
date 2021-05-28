let mapleader = " "
call plug#begin()

Plug 'lepture/vim-jinja'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'pangloss/vim-javascript'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'
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

call plug#end()

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

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_enable_snippet = 'Neosnippet'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

let g:leaderMenu = {'name':  "",
             \'fd': [":tabe $MYVIMRC",       "tabe vimrc"],
             \'ff': [":Telescope find_files",       "find files"],
             \'fb': [":Telescope bufers",       "buffers"],
             \'fh': [":Telescope help_tags",       "help"],
             \'fgc': [":Telescope git_commits",       "commits"],
             \'fgb': [":Telescope git_branches",       "branches"],
             \}

" Define leader key to space and call vim-leader-mapper
nnoremap <Space> <Nop>
let mapleader  "\<Space>"
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

