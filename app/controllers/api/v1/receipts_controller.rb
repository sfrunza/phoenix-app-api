module Api::V1
    class ReceiptsController < ApplicationController
      # before_action :set_image, only: [:show, :update, :destroy]
  
    def index
      if !current_user
        @receipts = Receipt.all.order('id DESC').where(job_id: 0)
        render json: @receipts
      else
        @receipts = Receipt.all.order('id DESC')
        render json: @receipts
      end
    end
  
    def show
      @receipt = Receipt.find(params[:id])
      render json: @receipt
    end
  
    def create
      @receipt = Receipt.create(receipt_params)
      @receipt.save
      render json: @receipt
    end
  
    def destroy
      receipt = Receipt.find(params[:id])
      receipt.destroy
    end
  
    protected
      # Never trust parameters from the scary internet, only allow the white list through.
      def receipt_params
        params.permit( :file, :id, :job_id)
      end
  
    end
  end
  