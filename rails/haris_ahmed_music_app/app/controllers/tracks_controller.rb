class TracksController < ApplicationController 
    before_action :require_current_user!
    before_action :only_admin!, only: [:new, :create, :edit, :update, :destroy]

    def create
        @track = Track.new(track_params)

        if @track.save 
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :new 
        end
    end

    def new
        @album = Album.find_by(id: params[:album_id])
        @track = Track.new
        render :new  
    end

    def edit
        @track = Track.find_by(id: params[:id])
        @album = @track.album 
        render :edit 
    end

    def update 
        @track= Track.find_by(id: params[:id])

        if @track.update_attributes(track_params)
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :edit 
        end
    end

    def show
        @track = Track.find_by(id: params[:id])
        @notes = @track.notes 

        if @track
            render :show 
        else
            redirect_to bands_url 
        end       
    end

    def destroy
        @track = Track.find_by(id: params[:id])

        if @track  
            @track.destroy
            redirect_to album_url(@track.album_id) 
        else
            flash.now[:errors] = @track.errors.full_messages
            redirect_to bands_url 
        end
    end

    private 
    def track_params
        params.require(:track).permit(:title, :ord, :bonus, :album_id, :lyrics)
    end

end