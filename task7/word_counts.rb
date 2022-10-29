
def prepare_string(string)
 string.downcase.split(/[^a-z']+/)
end

def get_top_3_frequent_words(array)
  array.group_by { |word| word } # group by words -> "in"=>["in", "in"]
       .reduce({}) { |map, (key, val)| map.merge(key => val.size)} # count frequency -> "in"=>2
       .sort_by {|key, value| value}
       .filter_map { |key, value| key if value > 1 }
       .reverse
       .first(3)
end

def get_result(string)
  array = prepare_string(string)
  get_top_3_frequent_words(array)
end

# puts "Enter text:"
# user_input = STDIN.gets.chomp

test = "In a village of La Mancha, the name of which I have no desire to call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income."
# ["a", "of", "on"]
puts "Result:" + get_result(test).to_s