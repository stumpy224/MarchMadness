require "spec_helper"

describe PayoutsController do
  describe "routing" do

    it "routes to #index" do
      get("/payouts").should route_to("payouts#index")
    end

    it "routes to #new" do
      get("/payouts/new").should route_to("payouts#new")
    end

    it "routes to #show" do
      get("/payouts/1").should route_to("payouts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/payouts/1/edit").should route_to("payouts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/payouts").should route_to("payouts#create")
    end

    it "routes to #update" do
      put("/payouts/1").should route_to("payouts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/payouts/1").should route_to("payouts#destroy", :id => "1")
    end

  end
end
