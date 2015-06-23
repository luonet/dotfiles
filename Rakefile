require 'rake'

DOTFILES = %w(
  gemrc
  gitconfig
  gitignore
  gvimrc
  pentadactylrc
  pryrc
  vimrc
).freeze

DOTFILES_DIR = ENV['PWD']
BACKUP_DIR   = "#{DOTFILES_DIR}/backup"

task :default => :install

desc 'Install all dotfiles'
task :install do
  DOTFILES.each { |file| install_file(file) }
end

desc 'Uninstall all dotfiles'
task :uninstall do
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

private

def install_file(file)
  puts "[Installing]\t .#{file}"

  source = "#{DOTFILES_DIR}/#{file}"
  target = "#{ENV['HOME']}/.#{file}"

  if File.exists?(target) &&
      (!File.symlink?(target) || File.readlink(target) != source)
    backup = "#{BACKUP_DIR}/.#{file}"
    puts "[Moving]\t #{target} -> #{backup}"
    run "mkdir -p #{BACKUP_DIR}"
    run "mv #{target} #{backup}"
  end

  puts "[Linking]\t #{target} -> #{source}"
  run "ln -nfs #{source} #{target}"

  puts
end

def uninstall_file(file)
  puts "[Uninstalling]\t .#{file}"

  backup = "#{BACKUP_DIR}/.#{file}"
  target = "#{ENV['HOME']}/.#{file}"

  if File.exists?(backup)
    puts "[Moving]\t #{backup} -> #{target}"
    run "mv #{backup} #{target}"
  else
    puts "[Removing]\t #{target}"
    run "rm #{target}"
  end

  puts
end

def run(cmd)
  ENV['DEBUG'] ? puts("[Running]\t #{cmd}") : `#{cmd}`
end
