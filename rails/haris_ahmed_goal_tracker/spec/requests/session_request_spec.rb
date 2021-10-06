require 'rails_helper'

RSpec.describe "Session", type: :request do
    describe "GET #new" do 
        it 'renders the new template' do 
            get new_session_path
            expect(response).to render_template(:new)
        end

    end
end