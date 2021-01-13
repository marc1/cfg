let vim_plug_installed = 0
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
	\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    let vim_plug_installed = 1
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . '/plugs')
    Plug 'itchyny/lightline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-colortemplate'
call plug#end()

if vim_plug_installed
    PlugInstall --sync
endif
unlet vim_plug_installed
