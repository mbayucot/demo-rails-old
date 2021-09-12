class V1::ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]

  # GET /v1/listings
  def index
    @listings = Listing.all

    render json: @listings
  end

  # GET /v1/listings/1
  def show
    render json: @listing
  end

  # POST /v1/listings
  def create
    @listing = current_user.listings.create!(listing_params)
    render json: @listing, status: :created
  end

  # PATCH/PUT /v1/listings/1
  def update
    @listing.update!(listing_params)
    render json: @listing
  end

  # DELETE /v1/listings/1
  def destroy
    @listing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.fetch(:listing, {}).permit(:title, :category, :description, :price, :condition, :tag_list, :photos)
    end
end
