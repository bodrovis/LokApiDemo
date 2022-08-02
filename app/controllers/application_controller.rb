require 'ruby_lokalise_api'

class ApplicationController < ActionController::Base
  private

  def api_client
    @client ||= RubyLokaliseApi.client ENV['LOKALISE_API_TOKEN']
  end
end
