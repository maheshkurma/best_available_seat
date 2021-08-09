class CreateBestSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :best_seats do |t|

      t.timestamps
    end
  end
end
