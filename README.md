# Warning

此文档刚刚创建，目前极不完善，马上会修改出一个更好的版本，敬请关注。

[English](https://github.com/luonet/dotfiles/blob/master/README.en.md)

# 说明

开发环境常用配置。主要为 vim 配置及插件，也包括了 git, tmux 等其他配置文件。

## 安装Vim

可选择自动或手动安装。

### 自动安装

```sh
sh -c "`curl -fsSL https://raw.githubusercontent.com/luonet/dotfiles/master/install`"
```

第一次安装时，会更新包管理程序，安装vim主程序，更新vim插件等，耗费的时间可能较长，请耐心等待。

### 手动安装

* clone项目：

  ```sh
  git clone https://github.com/luonet/dotfiles.git ~/.dotfiles
  cd ~/.dotfiles
  ```

* 查看所有可用任务及说明：

  ```sh
  rake -T
  ```

* 在执行前，可以先在DEBUG模式下查看将要执行的shell命令：

  ```sh
  DEBUG=1 rake
  ```

* 实际执行：

  ```sh
  rake
  ```

  当然也可复制前一步输出的命令手工执行。

### 更新

```sh
rake update
```

### 卸载

```sh
rake uninstall
```

注：卸载时只会删除配置文件，将保留vim主程序和插件（因配置文件已删除，将不会再被加载）。

## Vim配置及插件详细说明

[待续...]

## 其他配置文件

### 安装

全部安装：

```sh
rake install_dotfiles
```

或通过`rake -T`查看任务列表，然后选择性安装，如：

```sh
rake install_pryrc
```

### 卸载

全部卸载：

```sh
rake uninstall_dotfiles
```

卸载特定配置，如：

```sh
rake uninstall_pryrc
```

## 参考资料

- [YARD](https://github.com/skwp/dotfiles)。
