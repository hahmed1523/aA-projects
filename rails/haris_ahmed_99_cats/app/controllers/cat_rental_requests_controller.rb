class CatRentalRequestsController < ApplicationController


    def new 
        @cat_rental = CatRentalRequest.new 
        @cats = Cat.all 
        render :new
    end


    def create
        # @cat = Cat.new(cat_params)

        # if @cat.save
        #     redirect_to cat_url(@cat)
        # else
        #     render :new 
        # end
    end


    private
    
    def rent_params
        params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date,:status)
    end
end
