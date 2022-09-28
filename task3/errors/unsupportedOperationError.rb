
class UnsupportedOperationError < StandardError
  attr_reader :exception_type
  def initialize(msg = "Unsupported calculating operation", exception_type = "custom")
    @exception_type = exception_type
    super(msg)
  end
end
