# Pry.config.editor = proc { |file, line| "vim +#{line} #{file}" }
Pry.editor = 'vim'

begin
  require 'awesome_print'

  Pry.print = lambda do |_output, value, pry_object|
    pretty = value.ai(indent: 2)
    pry_object.pager.page("=> #{pretty}")
  end
rescue LoadError
  puts '请先安装或在Gemfile中添加awesome_print'
end
