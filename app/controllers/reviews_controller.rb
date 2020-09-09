# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[]

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    respond_to do |format|
      if @review.save!
        format.html { redirect_to @review.restaurant, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review.restaurant }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
