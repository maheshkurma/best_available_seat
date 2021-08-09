
class Api::BestSeatsController < ApplicationController
  ActionController::Parameters.permit_all_parameters = true

	def index
    response = BestSeat.find_best_available_seats(params)

    if response.success?
      render json:{ result: response.result }
    else
      render json: { error: response.errors }
    end
  end
end
