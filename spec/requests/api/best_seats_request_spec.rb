require 'rails_helper'

RSpec.describe "Api::BestSeats", type: :controller do
  context "with a venu of 10 rows and 12 columns for single seat", type: :request do
    before do
      get '/api/best_seats', params: {"venue"=>{"layout"=>{"rows"=>10, "columns"=>12}}, "seats"=>{"a5"=>{"id"=>"a5", "row"=>"a", "column"=>5, "status"=>"AVAILABLE"}, "a4"=>{"id"=>"a4", "row"=>"a", "column"=>4, "status"=>"AVAILABLE"}, "a6"=>{"id"=>"a6", "row"=>"a", "column"=>6, "status"=>"AVAILABLE"}, "a3"=>{"id"=>"a3", "row"=>"a", "column"=>3, "status"=>"AVAILABLE"}, "a2"=>{"id"=>"a2", "row"=>"a", "column"=>2, "status"=>"AVAILABLE"}, "a1"=>{"id"=>"a1", "row"=>"a", "column"=>1, "status"=>"AVAILABLE"}, "a7"=>{"id"=>"a7", "row"=>"a", "column"=>7, "status"=>"AVAILABLE"}}}
    end

    it "returns the best available seat that would be a6" do
      response_body = JSON.parse(response.body)
      expect(response_body.keys).to match_array(['result'])
      expect(response_body['result']).to match_array(["a6"])
    end
  end

  context "with a venu of 10 rows and 12 columns for three requested seats", type: :request do
    before do
      get '/api/best_seats', params: {"venue"=>{"layout"=>{"rows"=>10, "columns"=>12}}, "number_of_seats"=>3, "seats"=>{"a5"=>{"id"=>"a5", "row"=>"a", "column"=>5, "status"=>"AVAILABLE"}, "a4"=>{"id"=>"a4", "row"=>"a", "column"=>4, "status"=>"AVAILABLE"}, "a6"=>{"id"=>"a6", "row"=>"a", "column"=>6, "status"=>"AVAILABLE"}, "a3"=>{"id"=>"a3", "row"=>"a", "column"=>3, "status"=>"AVAILABLE"}, "a2"=>{"id"=>"a2", "row"=>"a", "column"=>2, "status"=>"AVAILABLE"}, "a1"=>{"id"=>"a1", "row"=>"a", "column"=>1, "status"=>"AVAILABLE"}, "a7"=>{"id"=>"a7", "row"=>"a", "column"=>7, "status"=>"AVAILABLE"}}}
    end

    it "JSON body response contains expected best_seats attributes" do
      response_body = JSON.parse(response.body)
      expect(response_body.keys).to match_array(['result'])
      expect(response_body['result']).to match_array(["a5", "a6", "a7"])
    end
  end

  context "with a venu of 10 rows and 5 columns for two requested seats", type: :request do
    before do
      get '/api/best_seats', params: {"venue"=>{"layout"=>{"rows"=>10, "columns"=>5}}, "number_of_seats"=>2, "seats"=>{"b5"=>{"id"=>"b5", "row"=>"b", "column"=>5, "status"=>"AVAILABLE"}, "b4"=>{"id"=>"b4", "row"=>"b", "column"=>4, "status"=>"AVAILABLE"}, "b3"=>{"id"=>"b3", "row"=>"b", "column"=>3, "status"=>"AVAILABLE"}, "b2"=>{"id"=>"b2", "row"=>"b", "column"=>2, "status"=>"AVAILABLE"}, "b1"=>{"id"=>"b1", "row"=>"b", "column"=>1, "status"=>"AVAILABLE"}}}
    end

    it "JSON body response contains expected best_seats attributes" do
      response_body = JSON.parse(response.body)
      expect(response_body.keys).to match_array(['result'])
      expect(response_body['result']).to match_array(["b2", "b3"])
    end
  end

  context "with a venu of 27 rows and 12 columns which row limit exceeds ", type: :request do
    before do
      get '/api/best_seats', params: {"venue"=>{"layout"=>{"rows"=>27, "columns"=>12}}, "seats"=>{"a5"=>{"id"=>"a5", "row"=>"a", "column"=>5, "status"=>"AVAILABLE"}, "a4"=>{"id"=>"a4", "row"=>"a", "column"=>4, "status"=>"AVAILABLE"}, "a6"=>{"id"=>"a6", "row"=>"a", "column"=>6, "status"=>"AVAILABLE"}, "a3"=>{"id"=>"a3", "row"=>"a", "column"=>3, "status"=>"AVAILABLE"}, "a2"=>{"id"=>"a2", "row"=>"a", "column"=>2, "status"=>"AVAILABLE"}, "a1"=>{"id"=>"a1", "row"=>"a", "column"=>1, "status"=>"AVAILABLE"}, "a7"=>{"id"=>"a7", "row"=>"a", "column"=>7, "status"=>"AVAILABLE"}}}
    end
   
    it "checks the row_limit and throws error" do
      response_body = JSON.parse(response.body)
      expect(response_body.keys).to match_array(['error'])
    end
  end
end
