require 'rails_helper'

RSpec.describe SchedulingController, type: :controller do
  before(:each) do
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: {}
      expect(response).to have_http_status(:success)
    end
  end
end