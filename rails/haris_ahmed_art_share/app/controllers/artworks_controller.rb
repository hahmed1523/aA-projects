class ArtworksController < ApplicationController
    def index
        render json: Artwork.all 
    end




    private

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end
end