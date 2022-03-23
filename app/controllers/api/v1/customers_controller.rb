module Api::V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: [:show, :update, :destroy]
  
      # GET /jobs
      def index
        if current_user
          @customers = Customer.all.order('created_at DESC')
          render json: @customers
        elsif current_customer
          @customers = Customer.all
          render json: {
            current_customer: @current_customer,
            logged_in: true,
          }
        else 
          render json: {current_customer: nil, message: "Please sign in.", status: 401, logged_in: false}
        end
  
      end
  
      # GET /jobs/1
      def show

      if current_user
        @customer = Customer.find(params[:id])
        render json: @customer, include: ["jobs"]
      elsif current_customer
        @customer = current_customer 
        render json: @customer, include: ["jobs"]
      else
        render json: {status: :not_found}
      end

        # if current_user && current_user.customer == false
        #   @job = Job.find(params[:id])
        #   @origin = @job.origin
        #   @destination = @job.destination
        #   @images = @job.images
        #   render json: @job
        # elsif current_user && current_user.customer == true
        #   @current_user = current_user
        #   @user_jobs = @current_user.jobs.find(params[:id])
        #   @origin = @user_jobs.origin
        #   @destination = @user_jobs.destination
        #   @images = @user_jobs.images
        #   render json: {job: @user_jobs, origin: @origin, destination: @destination, images: @images}
        # else
        #   render json: {message: "Please sign in."}
        # end
  
      end
  
      # POST /customer
      def create
        if Customer.exists?(email: customer_params[:email])
          @old_customer= Customer.find_by_email!(customer_params[:email])
        # UserMailer.with(user: @old_user).welcome_email.deliver_later
          render json: {
              customer: @old_customer
          }
        elsif @customer = Customer.new(customer_params)
          if @customer.save
          # UserMailer.with(user: @user).welcome_email.deliver_later
              render json: {
              status: :created,
              customer: @customer
              }
          end
        else
        render json: @customer.errors, status: :unprocessable_entity
        end
      end
  
      # PATCH/PUT /jobs/1
      def update
        if @customer.update(customer_params)
          render json: @customer
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end
  
      # DELETE /jobs/1
      def destroy
        @customer.destroy
      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_customer
          @customer = Customer.find(params[:id])
        rescue => e
          logger.info e
          render json: { message: 'customer id not found' }, status: :not_found
        end
  
      
  
        # Only allow a trusted parameter "white list" through.
        def customer_params
          params.require(:customer).permit(:id, :first_name, :last_name, :email, :phone, :add_phone, :password, :password_confirmation )
        end
    end
  end
  