class WebhooksController < ApplicationController
  def new
  end
  
  def create
    flash[:success] = 'Webhook registered!'

    

    redirect_to root_path
  end
end