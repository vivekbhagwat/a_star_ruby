@goal_square = [[nil,1,2],[3,4,5],[6,7,8]]

def h1(square)
  count = 0
  @goal_square.each_with_index do |row,i|
    row.each_with_index do |cell,j|
      unless cell == square[i][j]
        count += 1
      end
    end
  end
  count
end

#manhattan distance
def h2(square)
  man_dist = 0
  square.each_index do |i|
    square[i].each_index do |j|
      arr = square[i][j] ? one_dimension_to_two(square[i][j]) : [0,0]
      
      man_dist += (arr[0]-i).abs + (arr[1] - j).abs
    end
  end
  man_dist
end

def h3(square)
  own_dist = 0
  
  # do something with "blocks" of ungrouped tiles, 
  # translate that into number of moves based on size
  
  own_dist
end

def one_dimension_to_two(k)
  [k / 3, k % 3]
end

square = ([Array.new(3)] << Array.new(3) << Array.new(3))
test_square = [[nil,1,2],[4,5,3], [6,7,8]]
p square.inspect
p test_square.inspect
p @goal_square.inspect

p h1(test_square)
p h2(test_square)
