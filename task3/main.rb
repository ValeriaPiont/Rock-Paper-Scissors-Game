
require_relative 'calculator.rb'
require_relative 'errors/unsupportedOperationError'

ALLOWED_OPERATIONS = %w[+ - * /]

def process_to_int(number)
  unless is_integer?(number)
    raise ArgumentError.new "argument isn't integer #{number}"
  end
  number.to_i
end

def is_integer?(number)
  number.to_i.to_s == number
end

begin
  puts("Enter first number: ")
  first_number = process_to_int(gets.chomp)
  puts("Enter second number: ")
  second_number = process_to_int(gets.chomp)
  puts "Enter operation, allowed: + - * /"
  operation = gets.chomp

  result = Calculator.calculate(first_number, second_number, operation)
  puts "Result: #{result}"

rescue ArgumentError => ex
  puts "Invalid input #{ex.message}"
rescue UnsupportedOperationError => ex
  puts "An exception occurred because of #{ex.message}"
rescue => ex
  puts "Unexpected exception #{ex.message}"
end
