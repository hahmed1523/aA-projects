class NotesController < ApplicationController
    before_action :require_current_user!
    
    def create 
        @note = Note.new(note_params)
        @note.user_id = current_user.id 

        if @note.save
            redirect_to track_url(@note.track_id)
        else
            flash[:errors] = @note.errors.full_messages
            redirect_to track_url(@note.track_id)
        end

    end

    def destroy
        @note = Note.find_by(id: params[:id])
        track = @note.track_id

        if @note  
            @note.destroy
            redirect_to track_url(track) 
        else
            flash.now[:errors] = @track.errors.full_messages
            redirect_to track_url(track)
        end
    end


    private
    def note_params
        params.require(:note).permit(:message, :track_id)
    end
end