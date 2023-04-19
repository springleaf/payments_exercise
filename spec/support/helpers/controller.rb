module Helpers
  module Controller
    def json
      JSON.parse(response.body)
    end
  end
end