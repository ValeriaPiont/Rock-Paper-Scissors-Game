
class Cake
  attr_reader :row_count, :col_count
  attr_reader :piece_count, :piece_size, :pieces

  def initialize(cake)
    @cake = cake
    @rows = cake.lines.map {|line| line.chomp }

    @row_count = @rows.size
    @col_count = @rows.first.length

    @piece_count = @cake.count("o")
    @piece_size = @row_count * @col_count / @piece_count

    @pieces = []
  end

  def cut_piece(top_left, dimensions)
    row = @rows[top_left[1]]
    piece_string = row.strip.slice(top_left[0], dimensions[0])
    (1...dimensions[1]).each do |i|
      row = @rows[top_left[1] + i]
      piece_string += "\n" + row[/\s*/] + row.strip.slice(top_left[0], dimensions[0])
    end
    piece_string
  end

  def add_piece(piece)
    @pieces << piece
  end

  def remove_last_piece
    @pieces.pop
  end

  # Get next position which doesn't have a piece yet
  def next_top_left
    return [0, 0] if @pieces.empty?
    return nil if @pieces.size == @piece_count

    tr_list = @pieces.map { |piece| piece.top_right }
    bl_list = @pieces.map { |piece| piece.bottom_left }

    # Filter out corners which hit the side of another piece
    filtered_tr_list = tr_list.select { |tr|
      tr[1] >= (bl_list.map { |bl| bl[1] if bl[0] == tr[0] }.compact.max || -1) }
    filtered_bl_list = bl_list.select { |bl|
      bl[0] >= (tr_list.map { |tr| tr[0] if tr[1] == bl[1] }.compact.max || -1) }

    # Filter out corners at the edge of the cake
    filtered_tr_list = filtered_tr_list.select { |tr| tr[0] < @col_count }
    filtered_bl_list = filtered_bl_list.select { |bl| bl[1] < @row_count }

    # Select corners closest to the top
    tl_list = filtered_tr_list + filtered_bl_list
    tl_list = tl_list.select { |tl| tl[1] == tl_list.map { |tl2| tl2[1] }.min }

    # Choose left most corner
    tl_list.find { |tl| tl[0] == tl_list.map { |tl2| tl2[0] }.min }
  end

  # Get maximum width of a piece starting at top_left which doesn't overlap existing pieces
  def max_width(top_left)
    return @col_count if @pieces.empty?

    bl_list = @pieces.map { |piece| piece.bottom_left }
    bl_list = bl_list.select { |bl| bl[0] > top_left[0] && bl[1] > top_left[1] }
    return @col_count - top_left[0] if bl_list.empty?
    bl_list.map { |bl| bl[0] }.min - top_left[0]
  end

  # Get maximum height of a piece starting at top_left which doesn't overlap existing pieces
  def max_height(top_left)
    return @row_count if @pieces.empty?

    tr_list = @pieces.map { |piece| piece.top_right }
    tr_list = tr_list.select { |tr| tr[0] > top_left[0] && tr[1] > top_left[1] }
    return @row_count - top_left[1] if tr_list.empty?
    tr_list.map { |tr| tr[0] }.min - top_left[1]
  end
end

class Piece
  attr_reader :dimensions
  attr_reader :top_right, :bottom_left

  def initialize(the_cake, top_left, dimensions)
    @cake = the_cake
    @top_left = top_left
    @dimensions = dimensions
    @top_right = [@top_left[0] + @dimensions[0], @top_left[1]]
    @bottom_left = [@top_left[0], @top_left[1] + @dimensions[1]]
  end

  def to_s
    @piece_value ||= @cake.cut_piece(@top_left, @dimensions)
  end

  def valid?
    return false if @dimensions[1] > @cake.max_height(@top_left)
    return false if @dimensions[0] > @cake.max_width(@top_left)
    self.to_s.count("o") == 1
  end
end


def cut(cake)
  the_cake = Cake.new(cake)

  # Calculate possible piece dimensions
  dimensions_list = []
  Math.sqrt(the_cake.piece_size).floor.downto(1) do |short_side_length|
    if (the_cake.piece_size % short_side_length) == 0
      long_side_length = the_cake.piece_size / short_side_length
      dimensions_list.unshift([long_side_length, short_side_length])
      dimensions_list.push([short_side_length, long_side_length]) if (short_side_length != long_side_length)
    end
  end
  dimensions_list = dimensions_list.select { |dimensions|
    dimensions[0] <= the_cake.col_count && dimensions[1] <= the_cake.row_count }

  dimensions_index = 0
  while (dimensions_index < dimensions_list.size) && (the_cake.next_top_left != nil) do
    next_piece = Piece.new(the_cake, the_cake.next_top_left, dimensions_list[dimensions_index])
    if next_piece.valid?
      # Add piece and move onto another piece
      the_cake.add_piece(next_piece)
      dimensions_index = 0
    else
      dimensions_index += 1
      if dimensions_index >= dimensions_list.size
        # Have tried all possibilities with current set of pieces
        # Take out last piece and try next option
        last_piece = the_cake.remove_last_piece
        dimensions_index = dimensions_list.index(last_piece.dimensions) + 1 if last_piece != nil
        while last_piece != nil && dimensions_index >= dimensions_list.size do
          # Remove additional pieces until find a new option or all are exhausted
          last_piece = the_cake.remove_last_piece
          dimensions_index = dimensions_list.index(last_piece.dimensions) + 1 if last_piece != nil
        end
      end
    end
  end

  the_cake.pieces.map { |piece| piece.to_s }
end


cake = "
.o.o....
........
....o...
........
.....o..
........
".strip

cut(cake).each { |str| puts (str + "\n\n")}