require "spec_helper"

describe JobApplicationsController do
  describe "routing" do

    it "routes to #index" do
      get("/job_applications").should route_to("job_applications#index")
    end

    it "routes to #new" do
      get("/job_applications/new").should route_to("job_applications#new")
    end

    it "routes to #show" do
      get("/job_applications/1").should route_to("job_applications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/job_applications/1/edit").should route_to("job_applications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/job_applications").should route_to("job_applications#create")
    end

    it "routes to #update" do
      put("/job_applications/1").should route_to("job_applications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/job_applications/1").should route_to("job_applications#destroy", :id => "1")
    end

  end
end
