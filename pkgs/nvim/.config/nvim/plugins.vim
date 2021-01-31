let vim_plug_installed = 0
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
	\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
    execute 'source ' . fnameescape(autoload_plug_path)
    let vim_plug_installed = 1
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . '/plugs')
    Plug 'itchyny/lightline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'haze/sitruuna.vim'
    Plug 'lifepillar/vim-colortemplate'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

    Plug 'rust-lang/rust.vim'
    "Plug 'lervag/vimtex'
call plug#end()

if vim_plug_installed
    PlugInstall --sync
endif
unlet vim_plug_installed

" RUST
let g:rustfmt_command="rustup run nightly rustfmt"
let g:rustfmt_autosave=1
let g:rustfmt_fail_silently=1

"LSP
set completeopt=menuone,noinsert,noselect

lua << EOF
local lspconfig = require'lspconfig'

local on_attach = function(client)
    require'completion'.on_attach(client)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false, 
        virtual_text = false,
        signs = true,
        update_in_insert = false,
    }
)

lspconfig.rust_analyzer.setup({ on_attach=on_attach })
lspconfig.clangd.setup({ on_attach=on_attach })
EOF

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_backspace() ? "\<Tab>" :
    \ completion#trigger_completion()

function! s:check_backspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~ '\s'
endfunction

set updatetime=250
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
