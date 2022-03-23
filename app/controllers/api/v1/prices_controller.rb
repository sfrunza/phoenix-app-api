module Api::V1
  class PricesController < ApplicationController
    before_action :set_price, only: [:show, :edit, :update, :destroy]

    # GET /prices
    def index
      @prices = Price.all
      render json: @prices
    end

    # GET /prices/1
    def show
      @price = Price.find(params[:id])
      render json: @price
    end

    # GET /prices/new
    def new
      @price = Price.new
    end

    # GET /prices/1/edit
    def edit
      @price = Price.find(params[:id])
    end

    # POST /prices
    def create
      @price = Price.new(price_params)

      if @price.save
        render json: {
          status: :created,
          rate: @price
        }
      else
        render json: @price.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /prices/1
    def update
      @price = Price.find(params[:id])
      if @price.update(price_params)
        render json: @price
      else
        render json: @price.errors, status: :unprocessable_entity
      end
    end

    # DELETE /prices/1
    def destroy
      @price.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_price
        @price = Price.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def price_params
        params.require(:price).permit(:id, :two_men, :three_men, :four_men, :add_men, :add_truck)
      end
  end
end  
