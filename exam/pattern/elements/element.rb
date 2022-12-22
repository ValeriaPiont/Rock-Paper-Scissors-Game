
# Інтерфейс оголошує метод accept, який як аргумент
# може отримувати об'єкт, що реалізує інтерфейс відвідувача
class Element
  def accept(visitor)
    raise NotImplementedError
  end
end