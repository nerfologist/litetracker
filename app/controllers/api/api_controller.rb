module Api
  class ApiController < ApplicationController
    before_action :api_require_signed_in!

    private

    def api_require_signed_in!
      return head :unauthorized unless signed_in?
    end
  end
end
