require 'rails_helper'

RSpec.describe LogsController, type: :controller do

  describe "GET #athlete:references" do
    it "returns http success" do
      get :athlete:references
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #workout:references" do
    it "returns http success" do
      get :workout:references
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #date_completed:date" do
    it "returns http success" do
      get :date_completed:date
      expect(response).to have_http_status(:success)
    end
  end

end
