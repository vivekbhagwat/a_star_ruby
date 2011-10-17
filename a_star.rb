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

def at_goal(square)
  square.each_with_index do |row,i|
    row.each_with_index do |cell,j|
      if cell != @goal_square[i][j]
        return false
      end
    end
  end
  return true
end

def generate_random_square(n=3)
  rand_square = Marshal.load(Marshal.dump(@goal_square))
  nil_index = [0,0]
  
  #Adapted Box-Muller method of generating random numbers.
  #26 is specific to average for 3x3. Should be changed in future for other n's
  num_moves = (26 + 10*(Math.sqrt(-2*Math.log(rand)) * Math.cos(2 * Math::PI * rand))).to_i
  1.upto(num_moves) do
    possible_directions = [:up,:down,:left,:right]
    if nil_index[0] == 0
      possible_directions -= [:up]
    elsif nil_index[0] == (n-1)
      possible_directions -= [:down]
    end
    
    if nil_index[1] == 0
      possible_directions -= [:left]
    elsif nil_index[1] == (n-1)
      possible_directions -= [:right]
    end
    
    move = possible_directions[(possible_directions.size * rand).to_i]
    if move == :up
      # take val from i-1,j and put in i,j
      # take nil from i,j and put in i-1,j
      rand_square[nil_index[0]][nil_index[1]] = rand_square[nil_index[0]-1][nil_index[1]]
      rand_square[nil_index[0]-1][nil_index[1]] = nil
      nil_index[0] -= 1
    elsif move == :down
      # take val, from i+1, j and put in i,j
      rand_square[nil_index[0]][nil_index[1]] = rand_square[nil_index[0]+1][nil_index[1]]
      rand_square[nil_index[0]+1][nil_index[1]] = nil
      nil_index[0] += 1      
    elsif move == :left
      rand_square[nil_index[0]][nil_index[1]] = rand_square[nil_index[0]][nil_index[1]-1]
      rand_square[nil_index[0]][nil_index[1]-1] = nil
      nil_index[1] -= 1
    elsif move == :right
      rand_square[nil_index[0]][nil_index[1]] = rand_square[nil_index[0]][nil_index[1]+1]
      rand_square[nil_index[0]][nil_index[1]+1] = nil
      nil_index[1] += 1  
    end
  end
  
  p "max moves = #{num_moves}"
  rand_square
end

def one_dimension_to_two(k,n=3)
  [k / n, k % n]
end

def m(i)
  Marshal.load(Marshal.dump(i))
end

square = ([Array.new(3)] << Array.new(3) << Array.new(3))
test_square = [[nil,1,2],[4,5,3], [6,7,8]]
p square.inspect
p test_square.inspect
p @goal_square.inspect

p h1(test_square)
p h2(test_square)
p generate_random_square
