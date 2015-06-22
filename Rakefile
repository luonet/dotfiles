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

DIR = "#{ENV['HOME']}/.dotfiles"

task :default => :install

desc 'Install all dotfiles'
task :install do
  DOTFILES.each do |file|
    puts "[Processing]\t .#{file}"
    source = "#{DIR}/#{file}"
    target = "#{ENV['HOME']}/.#{file}"

    if File.exists?(target) &&
        (!File.symlink?(target) || File.readlink(target) != source)
      puts "[Moving]\t #{target} -> #{backup_dir}"
      run "mkdir -p #{backup_dir}"
      run "mv #{target} #{backup_dir}"
    end

    puts "[Linking]\t #{target} -> #{source}"
    run "ln -nfs #{source} #{target}"
    puts
  end
end

private

def run(cmd)
  ENV['DEBUG'] ? puts("[Running]\t #{cmd}") : `#{cmd}`
end

def backup_dir
  @backup_dir ||= "#{DIR}/backup-#{Time.now.to_i}/"
end
