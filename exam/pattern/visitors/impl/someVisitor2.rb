
class SomeVisitor2 < Visitor
  def visit_1(element)
    puts "#{element.method_for_element_1} - #{self.class}"
  end

  def visit_2(element)
    puts "#{element.method_for_element_2} - #{self.class}"
  end
end
