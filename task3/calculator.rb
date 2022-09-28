
class Calculator

  ALLOWED_OPERATIONS = %w[+ - * /]

  def self.calculate(first_number, second_number, operation)
    unless first_number.is_a?(Integer) && second_number.is_a?(Integer)
      raise ArgumentError.new "argument isn't integer"
    end
    unless ALLOWED_OPERATIONS.include?(operation)
      raise UnsupportedOperationError.new
    end
    case operation
    when '+'
      return first_number + second_number
    when '-'
      return first_number - second_number
    when '*'
      return first_number * second_number
    when '/'
      begin
        return first_number / second_number
      rescue ZeroDivisionError => exception
        puts "An exception occurred because of #{exception.message}"
      end
    else
      raise UnsupportedOperationError.new("Unknown operation #{operation}")
    end
  end

end
