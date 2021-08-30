class TracksController < ApplicationController 

    def create 
    end

    def new
        @album = Album.find_by(id: params[:album_id])
        @track = Track.new
        render :new  
    end

end