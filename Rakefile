task :default => :install

desc 'Install vim application, configurations and plugins'
task :install do
  update_package_manager_and_install_vim
  install_vim_configurations
  install_vundle_and_plugins
end

desc 'Uninstall vim configurations but keeping application and plugins'
task :uninstall do
  uninstall_vim_configurations
end

desc 'Update vim configurations and plugins'
task :update do
  p2('Updating', 'vim configurations') { run 'git pull' }
  p2('Updating', 'vim plugins') { run 'vim +PluginUpdate +qall', :system }
end

DOTFILES = %w(
  gemrc
  gitconfig
  gitignore
  gvimrc
  pentadactylrc
  pryrc
  vimrc
).freeze

desc 'Install all dotfiles'
task :install_dotfiles do
  DOTFILES.each { |file| install_file(file) }
end

desc 'Uninstall all dotfiles'
task :uninstall_dotfiles do
  DOTFILES.each { |file| uninstall_file(file) }
end

DOTFILES.each do |file|
  desc "Install #{file}"
  task "install_#{file}" do
    install_file(file)
  end

  desc "Uninstall #{file}"
  task "uninstall_#{file}" do
    uninstall_file(file)
  end
end

CURRENT_DIR = ENV['PWD']
BACKUP_DIR  = "#{CURRENT_DIR}/backup"

def install_file(file)
  p2('Installing', ".#{file}") do
    source = "#{CURRENT_DIR}/#{file}"
    target = "#{ENV['HOME']}/.#{file}"

    if File.exists?(target) &&
        (!File.symlink?(target) || File.readlink(target) != source)
      backup = "#{BACKUP_DIR}/.#{file}"
      run %(mkdir -p "#{BACKUP_DIR}")
      run %(mv "#{target}" "#{backup}")
    end

    run %(ln -nfs "#{source}" "#{target}")
  end
end

def uninstall_file(file)
  p2('Uninstalling', ".#{file}") do
    source = "#{CURRENT_DIR}/#{file}"
    target = "#{ENV['HOME']}/.#{file}"
    backup = "#{BACKUP_DIR}/.#{file}"

    if File.exists?(backup)
      run %(mv "#{backup}" "#{target}")
    elsif File.symlink?(target) && (File.readlink(target) == source)
      run %(rm "#{target}")
    end
  end
end

def update_package_manager_and_install_vim
  if RUBY_PLATFORM.downcase['darwin']
    `which brew`
    unless $?.success?
      p2('Installing', 'Homebrew') { run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"} }
    end

    p2('Updating', 'Homebrew')       { run 'brew update' }
    p2('Installing', 'ag and ctags') { run 'brew install ag ctags' }
    p2('Installing', 'vim')          { run 'brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit --HEAD' }
  else
    `which apt-get`

    if $?.success?
      p2('Updating', 'apt-get')        { run 'sudo apt-get update' }
      p2('Installing', 'ag and ctags') { run 'sudo apt-get install silversearcher-ag exuberant-ctags' }
      p2('Installing', 'vim')          { run 'sudo apt-get install vim vim-nox vim-gtk' }
    else
      p2('Warning', 'Can not find supporting package manager(brew/apt-get) to install vim')
      puts
    end
  end
end

def install_vim_configurations
  install_file 'vimrc'
  install_file 'gvimrc'
end

def uninstall_vim_configurations
  uninstall_file 'vimrc'
  uninstall_file 'gvimrc'
end

def install_vundle_and_plugins
  p2('Installing', 'Vundle') { run 'git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim' }

  p2('Installing', 'vim plugins') do
    # Extract only the vundle section from vimrc to a temporary vimrc.vundle,
    # which will soon be used to install plugins, for directly loading vimrc
    # before installing plugins will cause dependent errors.
    temp_vimrc = 'vimrc.vundle'

    if debug?
      p2 'Creating', "a temporary #{temp_vimrc} file"
    else
      File.open(temp_vimrc, 'w') do |f|
        File.read('vimrc') =~ /(.*call vundle#end\(\))/m
        f.puts($1)
      end
    end

    # Must use system('vim ...') to force vim to start automatically
    run "vim --noplugin -u #{temp_vimrc} +PluginInstall +qall", :system
    run "rm #{temp_vimrc}"
    run 'cd ~/.vim/bundle/vimproc.vim && make'
  end
end

def run(cmd, exe = nil)
  if debug?
    p2 'Running', cmd
  else
    # http://stackoverflow.com/questions/6338908/ruby-difference-between-exec-system-and-x-or-backticks
    # http://stackoverflow.com/questions/2232/calling-shell-commands-from-ruby
    exe == :system ? system(cmd) : `#{cmd}`
  end
end

def p2(bang, message)
  puts "[#{bang}]\t #{message}"
  if block_given?
    yield
    puts
  end
end

def debug?
  ENV['DEBUG']
end
