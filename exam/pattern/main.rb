
require_relative "elements/element"
require_relative "elements/impl/someElement1"
require_relative "elements/impl/someElement2"
require_relative "visitors/visitor"
require_relative "visitors/impl/someVisitor1"
require_relative "visitors/impl/someVisitor2"

components = [SomeElement1.new, SomeElement2.new]

puts 'SomeVisitor1'
visitor1 = SomeVisitor1.new
components.each do |component|
  component.accept(visitor1)
end

puts 'SomeVisitor2'
visitor2 = SomeVisitor2.new
components.each do |component|
  component.accept(visitor2)
end
