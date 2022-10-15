
class State2 < State

  def do_something
    puts 'State2'
    @context.move_to(State3.new)
  end

end
