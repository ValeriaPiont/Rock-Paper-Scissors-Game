

# Відвідувач описує загальний інтерфейс всіх типів відвідувачів.
# Він оголошує набір методів, що відрізняються типом вхідного параметра,
# які необхідні для запуску операції для всіх типів конкретних елементів.
class Visitor
  def visit_1(element)
    raise NotImplementedError
  end

  def visit_2(element)
    raise NotImplementedError
  end
end
