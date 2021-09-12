class V1::ListingsController < ApplicationController
  before_action :set_v1_listing, only: [:show, :update, :destroy]

  # GET /v1/listings
  def index
    @v1_listings = V1::Listing.all

    render json: @v1_listings
  end

  # GET /v1/listings/1
  def show
    render json: @v1_listing
  end

  # POST /v1/listings
  def create
    @v1_listing = V1::Listing.new(v1_listing_params)

    if @v1_listing.save
      render json: @v1_listing, status: :created, location: @v1_listing
    else
      render json: @v1_listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/listings/1
  def update
    if @v1_listing.update(v1_listing_params)
      render json: @v1_listing
    else
      render json: @v1_listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/listings/1
  def destroy
    @v1_listing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_listing
      @v1_listing = V1::Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_listing_params
      params.fetch(:v1_listing, {})
    end
end
