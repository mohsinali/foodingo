class VisitorsController < ApplicationController
	before_action :authenticate_user!

	def index
    @orders = Order.by_user(current_user.id).order(created_at: :desc)

    

    merchant = Parse::Object.new("merchants")
    obj_merchant = merchant.save
    obj_merchant["objectId"]
  end
end
