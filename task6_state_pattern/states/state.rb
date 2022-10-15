
class State

  attr_accessor :context

  def do_something
    raise "#{self.class} has not implemented method '#{__method__}'"
  end

end