class V1::CategoriesController < ApplicationController
  # GET /v1/categories
  def index
    @categories = Category.all
    render json: @categories
  end
end
