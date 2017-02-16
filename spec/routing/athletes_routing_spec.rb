require "rails_helper"

RSpec.describe AthletesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/athletes").to route_to("athletes#index")
    end

    it "routes to #new" do
      expect(:get => "/athletes/new").to route_to("athletes#new")
    end

    it "routes to #show" do
      expect(:get => "/athletes/1").to route_to("athletes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/athletes/1/edit").to route_to("athletes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/athletes").to route_to("athletes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/athletes/1").to route_to("athletes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/athletes/1").to route_to("athletes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/athletes/1").to route_to("athletes#destroy", :id => "1")
    end

  end
end
