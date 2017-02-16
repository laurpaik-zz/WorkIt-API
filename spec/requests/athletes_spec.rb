require 'rails_helper'

RSpec.describe "Athletes", type: :request do
  describe "GET /athletes" do
    it "works! (now write some real specs)" do
      get athletes_path
      expect(response).to have_http_status(200)
    end
  end
end
