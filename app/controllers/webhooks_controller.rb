class WebhooksController < ApplicationController

  def sync_mealhistory
    puts params

    render nothing: true, status: 200
  end
end
