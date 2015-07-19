# Guildance

luonet's vim and other dotfiles, partially referenced [YARD](https://github.com/skwp/dotfiles).

## Install Vim dotfile

Both automatic installation and manual installation are available.

### Automatic Installation

```sh
sh -c "`curl -fsSL https://raw.githubusercontent.com/luonet/dotfiles/master/install`"
```

It might take a long time for the first time installation because under the hood it will:

- Upgrade package management program
- Install vim
- Install vim Plugins

### Manual Installation

* clone the project

  ```sh
  git clone https://github.com/luonet/dotfiles.git ~/.dotfiles
  cd ~/.dotfiles
  ```

* see all available rake tasks

  ```sh
  rake -T
  ```

* dry run and print all shell commands that will be executed

  ```sh
  DEBUG=1 rake
  ```

* execute default task

  ```sh
  rake
  ```

### Upgrade

```sh
rake update
```

### Uninstall

```sh
rake uninstall
```

Note: Uninstallation will keep vim and plugins, but plugins won't be loaded because there's no configuration file.

## Vim Frequently Used Key Bindings

### List Available Key Bindings

- ```:map``` all mode key mappings
- ```:nmap``` normal mode key mappings
- ```:vmap``` visual mode key mappings
- ```:imap``` insert mode key mappings

### Movement Key Bindings

- [normal mode] ```f then id``` quick jump to any words in screen, the id for each word will be shown once you pressed ```f```
- [normal mode] ```ctrl and ]```  jump to definition (ctags), need to rebuild ctags first with ```ctags -R —exclude=node_modules```
- [normal mode] ```ctrl and o``` jump back to last cursor position
- [normal mode] ```ctrl and i``` jump back to next cursor position
- [normal mode] ```space then space``` jump to and jump back between current editing file and last edited file
- [normal mode] ```\` then \```` jump to and jump back between current editing line and last edited line

### Selection Key Bindings

- [normal mode] ```b then v then i then w``` select current word
- [normal mode] ```ctrl and n``` select multiple current word and edit them at the same time

### Comment Key Bindings

- [visual mode] ```g then c``` toggle comment

### Alignment Key Bindings

- [visual mode] ```enter then =``` align by =
- [visual mode] ```enter then =``` align by :

### Buffers (Windows) Key Bindings

- [normal mode] ```space then f``` find from files recursively
- [normal mode] ```space then e``` open buffer lists
- [normal mode] ```space then y``` open yank lists
- [normal mode] ```space then e``` open undo list, go back to any edited version
- [normal mode] ```space then s``` grep globally
- [normal mode] ```space then c``` open console
- [normal mode] ```space then b``` open tag bar
- [normal mode] ```space then w``` open a new horizontal buffer on the right
- [normal mode] ```space then q``` shortcut for :q
- [normal mode] ```space then o``` maximize current buffer
- [normal mode] ```space then t```  toggle directory tree
- [normal mode] ```ctrl and h/j/k/l```  move left/up/down/right among buffers

## Other dotfiles

### Installation

Install all dotfiles

```sh
rake install_dotfiles
```

Or install specific dotfile running rake tasks listed in ```rake -T```, e.g.:

```sh
rake install_pryrc
```

### Uninstallation

Uninstall all dotfiles

```sh
rake uninstall_dotfiles
```

Uninstall specific dotfile

```sh
rake uninstall_pryrc
```
