require 'rails_helper'
require 'spec_helper'

RSpec.describe ApplicationController, type: :controller do 

    describe "login_user!" do 
        it 'adds a session token to session' do 
            expect(session[:session_token].nil?).to eq(true)
            user = FactoryBot.create(:user)
            subject.login_user!(user)
            expect(session[:session_token].nil?).to eq(false)

        end
    end

    describe "current_user" do 
        it 'returns nil if there is no current user' do 
            expect(subject.current_user.nil?).to eq(true)
        end

        it 'returns the current user' do 
            user = FactoryBot.create(:user)
            subject.login_user!(user)
            expect(subject.current_user.nil?).to eq(false)
            
        end

    end


    describe "current_user_id" do 
        it 'returns nil if there is no current user' do 
            expect(subject.current_user_id.nil?).to eq(true)
        end

        it 'returns the current_user_id' do 
            user = FactoryBot.create(:user)
            subject.login_user!(user)
            expect(subject.current_user_id).to eq(user.id)
        end
    end

    describe "logged_in?" do 
        it 'returns false when there is no current user' do 
            expect(subject.logged_in?).to eq(false)
        end


        it 'returns true when there is a current user' do 
            user = FactoryBot.create(:user)
            subject.login_user!(user)
            expect(subject.logged_in?).to eq(true)
        end
    end

end