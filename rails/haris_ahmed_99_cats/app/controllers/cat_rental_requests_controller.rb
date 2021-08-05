class CatRentalRequestsController < ApplicationController


    def new 
        @cat_rental = CatRentalRequest.new 
        @cats = Cat.all 
        render :new
    end


    def create
        @cat_rental = CatRentalRequest.new(rent_params)

        if @cat_rental.save 
            redirect_to cat_url(@cat_rental.cat_id)
        else
            render :new 
        end

    end


    private
    
    def rent_params
        params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date,:status)
    end
end
