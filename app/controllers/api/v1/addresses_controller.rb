module Api::V1
    class AddressesController < ApplicationController
      before_action :set_address, only: [:show, :update, :destroy]
  
      # GET /addresses
      def index
        @addresses = Address.all.order('id DESC')
  
        render json: @addresses
      end
  
      # GET /addresses/1
      def show
        address = Address.find(params[:id])
        render json: {address: address}
  
      end
  
      # POST /addresses
      def create
        @address = Address.new(address_params)
  
        if @address.save
          render json: {
            status: :created,
            address: @address
          }
        else
          render json: @address.errors, status: :unprocessable_entity
        end
      end
  
      # PATCH/PUT /addresses/1
      def update
        if @address.update(address_params)
          render json: @address
        else
          render json: @address.errors, status: :unprocessable_entity
        end
      end
  
      # DELETE /addresses/1
      def destroy
        @address.destroy
      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_address
          @address = Address.find(params[:id])
        end
  
        # Only allow a trusted parameter "white list" through.
        def address_params
          permitted = params.require(:address)
          permitted.permit(:address, :city, :state, :zip, :job_id, :floor, :apt_number, :is_origin, :is_destination, :is_pickup, :is_dropoff)
        end
    end
  end
  