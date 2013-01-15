require "spec_helper"

describe IdeasController do
  describe "routing" do

    it "routes to #index" do
      get("/agendas/1/ideas").should route_to("ideas#index", :agenda_id => "1")
    end

    it "routes to #new" do
      get("/agendas/1/ideas/new").should route_to("ideas#new", :agenda_id => "1")
    end

    it "routes to #show" do
      get("/agendas/1/ideas/1").should route_to("ideas#show", :agenda_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/agendas/1/ideas/1/edit").should route_to("ideas#edit", :agenda_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/agendas/1/ideas").should route_to("ideas#create", :agenda_id => "1")
    end

    it "routes to #update" do
      put("/agendas/1/ideas/1").should route_to("ideas#update", :agenda_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/agendas/1/ideas/1").should route_to("ideas#destroy", :agenda_id => "1", :id => "1")
    end

  end
end
