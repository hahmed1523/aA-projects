class BandsController < ApplicationController

    def index
        @bands = Band.all
        render :index
    end

    def show
        @band = Band.find_by(id: params[:id])

        if @band 
            render :show
        else 
            redirect_to bands_url
        end
    end

    def new
        @band = Band.new
        render :new 
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new 
        end
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end

end
