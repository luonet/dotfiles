配置文件说明
============

常用配置文件，部分参考了[YARD](https://github.com/skwp/dotfiles)

安装配置
--------

```
git clone [REMOTE_URL] ~/.dotfiles && cd ~/.dotfiles && rake
```

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

* 安装插件, 打开vim执行`:PluginInstall`

* 编译vimproc

  ```
  cd ~/.vim/bundle/vimproc.vim && make
  ```

* 安装ag, ctags:

  ```
  brew install ag ctags
  ```
