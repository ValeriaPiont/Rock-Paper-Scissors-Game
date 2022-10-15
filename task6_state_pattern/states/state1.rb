
class State1 < State

  def do_something
    puts 'State1'
    @context.move_to(State2.new)
  end

end
