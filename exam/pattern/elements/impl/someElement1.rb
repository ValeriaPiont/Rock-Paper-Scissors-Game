
# Кожен Конкретний Компонент повинен реалізувати метод accept таким чином,
# щоб він викликав метод відвідувача, що відповідає класу компонента
class SomeElement1 < Element

  def accept(visitor)
    visitor.visit_1(self)
  end

  def method_for_element_1
    'SomeElement1'
  end
end
