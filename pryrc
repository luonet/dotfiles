Pry.editor = 'vim'

require "awesome_print"
AwesomePrint.pry!

Pry.print = lambda do |_output, value, pry_object|
  pretty = value.ai(:indent => 2)
  pry_object.pager.page("=> #{pretty}")
end
