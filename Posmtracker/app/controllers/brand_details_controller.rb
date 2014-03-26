class BrandDetailsController < ApplicationController
 
  # GET /brands
  def get_brand_list
           json = {"success" => 1, "message" => BrandDetail.get_details}
          render :json => json
  end
 
end
