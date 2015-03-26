module LocGem
  class Base
    def initialize
      @loc_conn = Faraday.new(:url => 'http://www.loc.gov') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end


    def loc_pictures(query)
      response = @loc_conn.get do |req|
        req.url "/pictures/search/"
        req.headers['Content-Type'] = 'application/json'
        req.params['fo'] = 'json'
        req.params['q'] = query
      end
      JSON.parse(response.body)
    end
    end
  end
end
