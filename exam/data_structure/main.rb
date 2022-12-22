
require_relative 'node'
require_relative 'tree'

def print_orders(tree)
  puts
  puts "Дерево:"
  puts "Прямий порядок:"
  puts tree.NLR.join(", ")
  puts "Зворотний порядок:"
  puts tree.LRN.join(", ")
  puts "Центрований порядок :"
  puts tree.LNR.join(", ")
end

puts "Рандомний масив, з якого буде створено дерево:"

array = Array.new(15) { rand(1..100) }
print array
puts

tree = Tree.new(array)

print_orders(tree)

puts
puts "Додаємо елемент 777 до дерева"
tree.insert(777)

print_orders(tree)

puts
puts "Шукаємо цей елемент у дереві"
puts tree.find(777)

puts
puts "Видяляємо елемент 777"
tree.delete(777)

print_orders(tree)
