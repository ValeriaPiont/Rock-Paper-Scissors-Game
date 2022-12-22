
class SomeElement2 < Element
  def accept(visitor)
    visitor.visit_2(self)
  end

  def method_for_element_2
    'SomeElement2'
  end
end
