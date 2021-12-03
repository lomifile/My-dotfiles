# My dotfiles

Here are the dotfiles that I use on all of my Linux setups. Doesn't matter which distribution you use, it should work right out of the box. Just make sure you have all programs on the given list.

<img src="pics/Term.png" />

Programs that I use for this to work:
1. [alacritty](https://github.com/alacritty/alacritty) -> Terminal emulator.
2. [tmux](https://github.com/tmux/tmux) -> Terminal multiplexer. 
3. [fish-shell](https://fishshell.com/) -> If you want this to work out of the box you will need fish shell.
4. [fisher](https://github.com/jorgebucaran/fisher) -> Using it to install theme which is [Tide](https://github.com/IlanCosman/tide) and to install extensions like nvm.
5. [git](https://git-scm.com/) -> It comes in almost every Linux distribution, but if you don't have it just install it from your package manager.
6. [exa](https://github.com/ogham/exa) -> Much better alternative to ls, just make sure you install icons and it will look much cleaner.
7. tree -> When I'm working on a project I use this command to structure my files.
8. [neovim](https://neovim.io/) -> Editor

# Instalation

To use my dotfiles you will need to copy all of the dotfiles into .config, as folder structure suggests.

# Neovim installation

To use neovim as configured in my init.vim you will need to install [Vundle](https://github.com/VundleVim/Vundle.vim). After you install Vundle just type ```:PluginInstall``` and it will start the installation process. After Vundle is done installing all of the extensions you will need to build [coc](https://github.com/neoclide/coc.nvim) using [Yarn](https://yarnpkg.com/).
After you build both run ```nvim``` or ```v``` for coc to finish the configuration.

I use theme iceberg, but If you don't like that specific theme you can modify ```colorscheme``` and <br /> ```let g:airline_theme``` with the theme you like.
[Theme resource](https://github.com/rafi/awesome-vim-colorschemes) and [Airline theme resource](https://github.com/vim-airline/vim-airline-themes).

<img src="pics/Editor.png" />

# Issues 

This is Linux specific setup, as I am mainly Linux user.
This has been tested and proven working on my machines but issues can happen and if you come across one feel free to open it here. Have fun using it :smile:
