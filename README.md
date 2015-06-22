配置文件说明
============

常用配置文件，部分参考了[YARD](https://github.com/skwp/dotfiles)

Vim安装流程
-----------

* 安装vim, 需要支持lua, [neocomplete](https://github.com/Shougo/neocomplete.vim)要用到:

  Mac:

  ```
  brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit --HEAD
  ```

  Ubuntu:

  ```
  sudo apt-get install vim-nox
  ```

* 安装[vundle](https://github.com/gmarik/Vundle.vim):

  ```
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ```

* 建立软连接:

  ```
  cd ~ && ln -s ~/.dotfiles/vimrc .vimrc && ln -s ~/.dotfiles/gvimrc .gvimrc
  ```

* 安装插件, 打开vim执行`:PluginInstall`

* 需要进入插件vimproc的目录运行`make`
