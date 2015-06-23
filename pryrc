# Pry.config.editor = proc { |file, line| "vim +#{line} #{file}" }
Pry.editor = 'vim'

begin
  require 'awesome_print'

  Pry.print = lambda do |_output, value, pry_object|
    pretty = value.ai(indent: 2)
    pry_object.pager.page("=> #{pretty}")
  end
rescue LoadError
  puts 'Please run `gem install awesome_print` or add it to Gemfile.'
end
