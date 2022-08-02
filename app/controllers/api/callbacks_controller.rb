module Api
  class CallbacksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:notify]

    def notify
      head :ok
    end
  end
end