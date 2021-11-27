# My dotfiles

Here are my dotfiles that I use on all of my Linux setups. Doesn't matter which distribution you use, it should work right out of the box. Just make sure you have all programs in given list.

<img src="pics/Term.png" />

Programs that I use for this to work:
1. [alacritty](https://github.com/alacritty/alacritty) -> Terminal emulator.
2. [fish-shell](https://fishshell.com/) -> If you want this to work out of the box you will need fish shell.
3. [fisher](https://github.com/jorgebucaran/fisher) && [omf](https://github.com/oh-my-fish/oh-my-fish) -> I am using this two for addon instalation like nvm and omf has great selection of the themes. Mine is bobthefish.
4. [git](https://git-scm.com/) -> It comes in almost every Linux distribution, but if you don't have it just install it from you package manager.
5. [exa](https://github.com/ogham/exa) -> Much better alternative to ls, just make sure you install icons and it will look much cleaner.
6. tree -> When I'm working on project I use this command to structure my files.
7. [vim](https://www.vim.org/) -> Editor

# Instalation

To use my dotfiles you will need to copy all of the dotfiles into .config, except .vimrc he goes into /home/{Your name}.

# Vim installation

To use vim as configured in my .vimrc you will need to install [Vundle](https://github.com/VundleVim/Vundle.vim). After you install Vundle just type ```:PluginInstall``` and it will start instalation process. After Vundle is done installing all of the extensions you will need to build [YCME](https://github.com/ycm-core/YouCompleteMe) and [coc](https://github.com/neoclide/coc.nvim).
After you build both run ```vim``` or ```v``` for coc to finish configuration.

<img src="pics/Editor.png" />

# Issues 
This has been tested and proven working on my machines but issues can happen and if you come across one feel free to open it here. Have fun using it :smile: