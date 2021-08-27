class AlbumsController < ApplicationController


    # def index
    #     if params.has_key?(:band_id)
    #         @band = Band.find_by(id: params[:band_id])
    #         @albums = @band.albums 
    #         render :index
    #     else
    #         redirect_to bands_url
    #     end 
    # end

    def new
        @band = Band.find_by(id: params[:band_id])
        @album = Album.new
        render :new  
    end

    def create
        @album = Album.new(album_params)
        @band = @album.band 

        if @album.save
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new 
        end
    end

    def show
        @album = Album.find_by(id: params[:id])
        

        if @album
            # @albums = @band.albums
            render :show
        else 
            redirect_to bands_url
        end
    end

    def edit
        @album = Album.find_by(id: params[:id])
        @band = @album.band
        render :edit 
    end

    def update
        @album = Album.find_by(id: params[:id])

        if @album.update_attributes(album_params)
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :edit 
        end
    end

    def destroy
        @album = Album.find_by(id: params[:id])

        if @album  
            @album.destroy
            redirect_to band_url(@album.band_id) 
        else
            flash.now[:errors] = @band.errors.full_messages
            redirect_to bands_url 
        end
    end

    private
    def album_params
        params.require(:album).permit(:title, :year, :live, :band_id)
    end
end