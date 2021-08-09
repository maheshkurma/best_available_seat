class BestSeat < ApplicationRecord
  enum map_rows: { 1 =>'A', 2 =>'B', 3 =>'C', 4 =>'D', 5 =>'E', 6 =>'F', 7 =>'G',
    8 =>'H', 9 =>'I', 10 =>'J', 11 =>'K', 12 =>'L', 13 =>'M', 14 =>'N',
    15 =>'O', 16 =>'P', 17 =>'Q', 18 =>'R', 19 =>'S', 20 =>'T', 21 =>'U',
    22 =>'V', 23 =>'W', 24 =>'X', 25 =>'Y', 26 =>'Z',
  }
  AVAILABLE = "AVAILABLE"
  RESERVED = "RESERVED"
  EXCEPTION_HANDLER = ""
  STATUS = "status"
  ROW_LIMIT_MAX = 26
  CORRIDOR_PRIORITY = 1
  EXCEPTION_PRIORITY = -1

  def self.find_best_available_seats(params)
    BestSeatService.new(params).call
  end
end
