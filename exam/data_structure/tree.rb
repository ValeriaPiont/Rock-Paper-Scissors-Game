
class Tree
  attr_reader :root

  def initialize(array)
    array.sort!.uniq!

    @root = build_tree(array)
  end

  def build_tree(array)
    return unless array[0]
    return Node.new(array[0]) if array.length <= 1

    middle = array.length / 2

    root = Node.new(array[middle])
    root.left = build_tree(array[0...middle])
    root.right = build_tree(array[middle + 1..-1])
    root
  end

  def insert(value)
    current = @root

    loop do
      # якщо значення вже є у дереві, воно не буде додано
      if current == value
        return
        # якщо значення меньше поточного, йдемо у ліву сторону
      elsif current > value
        next_node = current.left
        # якщо більше - у праву
      else
        next_node = current.right
      end

      break if next_node == nil

      current = next_node
    end

    # коли знайдено останній вузол, додаємо значення
    if current > value
      current.left = Node.new(value = value)
    else
      current.right = Node.new(value = value)
    end
  end

  ORDERS = %w[NLR LNR LRN]
  ORDERS.each do |method|
    define_method "#{method}" do |current = @root, result = [], &block|

      return if current == nil

      if method == ORDERS[0]
        block ? block.call(current.value) : result << current.value
      end

      self.send(method, current.left, result, &block)

      if method == ORDERS[1]
        block ? block.call(current.value) : result << current.value
      end

      self.send(method, current.right, result, &block)

      if method == ORDERS[2]
        block ? block.call(current.value) : result << current.value
      end

      block ? nil : result
    end
  end

  def find(value, current = @root)
    return false if current == nil
    return current if current == value

    begin
      if current > value
        find(value, current.left)
      else
        find(value, current.right)
      end
    rescue ArgumentError
      return false
    end
  end

  def delete(value)
    node = find(value)
    if node == false
      return false
    end

    parent = find_parent(node)

    if node.left == nil and node.right == nil
      delete_leaf(node, parent)
    elsif (node.left != nil) ^ (node.right != nil)
      child = (node.left or node.right)

      if node == @root
        old_root = @root
        @root = child
        return old_root
      end

      if node > parent
        parent.right = child
      else
        parent.left = child
      end
      node

    else
      next_biggest_node = find_next_biggest_node(node)
      delete(next_biggest_node)

      node.value = next_biggest_node.value
    end
  end

  private def find_parent(node)
    # the root has no parent
    if @root == node
      return
    end

    current = @root
    loop do
      if current.left == node or current.right == node
        break
      elsif current > node
        current = current.left
      else
        current = current.right
      end
    end
    current
  end

  private def delete_leaf(node, parent)
    return false if node.left != nil or node.right != nil

    if parent.left == node
      parent.left = nil
      node
    elsif parent.right == node
      parent.right = nil
      node
    else
      false
    end
  end

  private def find_next_biggest_node(node)
    next_node = node.right
    return node if next_node == nil
    while next_node.left != nil do
      next_node = next_node.left
    end
    next_node
  end

end
