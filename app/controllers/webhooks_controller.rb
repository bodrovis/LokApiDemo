# Task: whenever a translation file is uploaded on Lokalise,
# create a new translation order. Then once the order is completed
# send a PR to a GitHub repo with all the translation data.

# Solution:

# 1. Register webhooks to listen to file
# uploads and order completion

# 2. When the file is uploaded, automatically
# create a new translation order with Google MT provider

# 3. When the order is completed, automatically
# initiate file export and fire GitHub trigger to create a new PR

# 4. Proceed to PRs on GH and merge it! 

# Translation project ID 5403957862e90981d0b0c8.60288957
# App URL https://lokapidemo.herokuapp.com/

class WebhooksController < ApplicationController
  def new
  end

  def create
    api_client.create_webhook params[:project_id],
                              url: 'https://lokapidemo.herokuapp.com/api/callbacks/notify',
                              events: %w[project.imported team.order.completed]

    flash[:success] = 'Webhook registered!'

    

    redirect_to root_path
  end
end