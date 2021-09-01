class NotesController < ApplicationController
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
    end


    private
    def note_params
        params.require(:note).permit(:message, :track_id)
    end
end