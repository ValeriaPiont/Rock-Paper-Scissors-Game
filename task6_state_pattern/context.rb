
require_relative 'states/state'
require_relative 'states/state1'
require_relative 'states/state2'
require_relative 'states/state3'

class Context

  # current state
  attr_accessor :state

  # constructor
  def initialize(state)
    move_to(state)
  end

  # change state
  def move_to(state)
    puts "Context: Transition to #{state.class}"
    @state = state
    @state.context = self
  end

  def request
    @state.do_something
  end

end

context = Context.new(State1.new)
context.request
context.request
context.request
