class BestSeatService
  def initialize(options = {})
    @venue = options[:venue]
    @seats = options[:seats]
    @rows = @venue[:layout][:rows].to_i
    @columns = @venue[:layout][:columns].to_i
    @available_seats =  find_available_seats(@seats.to_hash)
    @number_of_seats = options[:number_of_seats].nil? ? 1 : options[:number_of_seats]
    @priority = options[:priority]
  end

  def call
    return failure if @rows > BestSeat::ROW_LIMIT_MAX

    best_seats_reference = find_best_middle_seats(@rows,@columns)
    @result = find_group_of_best_seats(best_seats_reference,@available_seats,@number_of_seats,@priority)

    return success
  end

  def check_row_limit
    binding.pry
  end

  def find_available_seats(seats)
    arr = []
    seats.each do |key, value|
      if (seats[key][BestSeat::STATUS] == BestSeat::AVAILABLE)
        arr.push(key)
      end
    end
    return arr
  end

  def find_best_middle_seats(rows,columns)
    position = 1 
    best_column = columns.fdiv(2).ceil
    hash = Hash.new

    Array(1..rows).each do |value| 
      1.times do |i|
        hash[position] = BestSeat.map_rows[value].downcase.concat(best_column.to_s)
        #add 1 in order to get second best
        best_column+=1 
      end
      position+=1
      1.times do |i|
        hash[position] = BestSeat.map_rows[value].downcase.concat(best_column.to_s)
        #minus 1 in order to get back to best column index
        best_column-=1 
      end
      position+=1
    end

    return hash
  end

  def find_group_of_best_seats(best_seats_reference,available_seats,number,priority_value)
    priority = priority_value.nil? ? BestSeat::EXCEPTION_PRIORITY : priority_value
    seat_before = ''
    seat_after = ''
    # limit refer to number of seats requested
    limit = number.to_i
    result = []
    available_seats_sorted = available_seats.sort
    
    available_seats_sorted.each do |seat|
    # check if the best seats group contains such elements
      if best_seats_reference.has_value?(seat)
        unless result.include?(seat)
          if result.size < limit
            result.push(seat)
          end
        end
        if BestSeat::CORRIDOR_PRIORITY != priority
          # add seat right before if available
          1.times do |i|
            seat_before = seat[0] + ((seat[1,seat.size].to_i)-1).to_s
            if  available_seats_sorted.include?(seat_before)
              unless result.include?(seat_before)
                if result.size < limit
                  result.push(seat_before)
                end
              end
            end
          end
            
          # add seat right next if available
          1.times do |i|
            seat_after = seat[0] + ((seat[1,seat.size].to_i)+1).to_s
            if  available_seats_sorted.include?(seat_after)
              unless result.include?(seat_after)
                if result.size < limit
                  result.push(seat_after)
                end
              end
            end
          end
        end    
      end 
    end
    
    # this section check with another seats is closer than reference seats position, which are by corridor
    closer_to_ref=''
    aux = []
    best_seats_reference_parameter = best_seats_reference[1][1,best_seats_reference[1].size].to_i
    closer_to_ref_integer = best_seats_reference_parameter
    best_seats_reference.each do |key, value|
      available_seats.each do |seat|
        if best_seats_reference[key].include?(seat[0])
          if (closer_to_ref_integer > (best_seats_reference_parameter - seat[1,seat.size].to_i).abs()) 
            aux.push(seat)
            closer_to_ref = seat
            closer_to_ref_integer = (best_seats_reference_parameter - seat[1,seat.size].to_i).abs()
          end
        end 
      end
    end
    while result.size < limit do
      unless result.include?(aux.last) && aux.size > 0
        if result.size < limit
          result.push(aux.last)
          aux.pop()
        end
      end
    end

    return result.sort
  end

  def failure
    OpenStruct.new(success?: false, result: nil,
                   errors: "Row limit exceeded")
  end

  def success
    OpenStruct.new(success?: true, result: @result,
                   errors: nil)
  end

end