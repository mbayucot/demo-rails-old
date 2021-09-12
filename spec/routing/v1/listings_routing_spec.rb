require "rails_helper"

RSpec.describe V1::ListingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/listings").to route_to("v1/listings#index")
    end

    it "routes to #show" do
      expect(get: "/v1/listings/1").to route_to("v1/listings#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/v1/listings").to route_to("v1/listings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/listings/1").to route_to("v1/listings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/listings/1").to route_to("v1/listings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/listings/1").to route_to("v1/listings#destroy", id: "1")
    end
  end
end
