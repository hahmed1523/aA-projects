class AlbumsController < ApplicationController

    def index
        if params.has_key?(:band_id)
            @band = Band.find_by(id: params[:band_id])
            @albums = @band.albums 
            render :index
        else
            redirect_to bands_url
        end 
    end
end