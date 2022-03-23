module Api::V1
  class JobsController < ApplicationController
    # Pagy::DEFAULT[:max_per_page] = 10
    before_action :set_job, only: [:show, :update, :destroy]
    before_action :set_job_user, only: [:show]

    # GET /jobs
    def index
      if current_user && current_user.admin        
        @jobs = Job.all.order('created_at DESC')
        # @jobs = Job.all.order('created_at DESC').paginate :page => params[:page], :per_page => 15

        # objects_to_display = Job.page(params[:page] ? params[:page].to_i : 1)
        # render json: @jobs, meta: pagination_meta(@jobs) 
        render json: @jobs
      elsif current_user && !current_user.admin
        @jobs = Job.where(job_status: "Confirmed").or(Job.where(job_status: "Completed"))
        render json: @jobs, include: ["users", "addresses"]
      elsif current_customer
        @jobs = current_customer.jobs.order('created_at DESC')
        render json: @jobs, include: ["users", "addresses"]
      else   
        
        render json: {message: "Please sign in."}
      end
    end

    # GET /jobs/1
    def show
      if current_user && current_user.admin
        @job = Job.find(params[:id])
        render json: @job, include: ["users", "addresses"]
      elsif current_user 
        @jobs = Job.where(job_status: "Confirmed").or(Job.where(job_status: "Completed"))
        @job = @jobs.find(params[:id])
        if @job
          render json: @job, include: ["users", "addresses"]
        else 
          render json: { message: 'job id not found' }, status: :not_found
        end
        
      elsif current_customer
        @jobs = current_customer.jobs
        @job = @jobs.find(params[:id])
        if @job
          render json: @job, include: ["users", "addresses"]
        else 
          render json: { message: 'job id not found' }, status: :not_found
        end

      else   
        render json: {message: "Please sign in."}
      end
    end

    # POST /jobs
    def create
      @job = Job.new(job_params)
      @customer = Customer.find(job_params[:customer_id])
      # @email = NewJobEmail.new(job_params)
      if @job.save
        if @job.job_type != "Moving from Storage"
          UserMailer.with(customer: @customer, job: @job).new_job_email.deliver_later
          UserMailer.with(customer: @customer, job: @job).welcome_email.deliver_later
        end
      
        render json: {
          status: :created,
          job: @job
        }
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /jobs/1
    def update
      if params.has_key?(:user_ids)
      @users = User.find(params[:user_ids])
      @job.users << @users
      else 
        @job.users = []
        @job.user_ids = []
        @job.job_duration = nil
        @job.total_amount = nil
      end
      if @job.update(job_params)
        # @customer = Customer.find(@job.customer_id)
        # UserMailer.with(customer: @customer, job: @job).status_email(@job).deliver_later
        render json: @job
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    end

    # DELETE /jobs/1
    def destroy
      @job.destroy
    end

    def pagination_meta(object)        {        
      current_page: object.current_page,             
      per_page: object.per_page,        
      total_pages: object.total_pages,   
      total_entries: object.total_entries      }    
     end
    

    #-----------------------------------------------------------------
    def send_confirm_availability
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_confirm_availability(@job).deliver_later
      render json: @job
    end

    def send_an_follow_up
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_an_follow_up(@job).deliver_later
      render json: @job
    end

    def send_moving_confirmation
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_moving_confirmation(@job).deliver_later
      render json: @job
    end

    def send_permit_information
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_permit_information(@job).deliver_later
      render json: @job
    end

    def send_survival_box_information
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_survival_box_information(@job).deliver_later
      render json: @job
    end

    def send_next_day_move_reminder
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_next_day_move_reminder(@job).deliver_later
      render json: @job
    end

    def send_moving_receipt
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).send_moving_receipt(@job).deliver_later
      render json: @job
    end

    def ask_for_review
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)

      JobMailer.with(customer: @customer, job: @job).ask_for_review(@job).deliver_later
      render json: @job
    end

    def deposit_paid
      @job = Job.find(params[:id])
      @customer = Customer.find(@job.customer_id)
      JobMailer.with(customer: @customer, job: @job).deposit_paid(@job).deliver_later
      render json: @job
    end

    def search_reviews
      url = ENV["SEARCH_PATH"]
      api_key = ENV["API_KEY"]
      @response = HTTP.auth("Bearer #{api_key}").get(url)
      # response.parse
      render json: @response.parse
    end

    #-----------------------------------------------------------------

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_job
        @job = Job.find(params[:id])
      rescue => e
        logger.info e
        render json: { message: 'job id not found' }, status: :not_found
      end

      def set_job_user
        @job = Job.where(id: params[:id], job_status: "Confirmed").or(Job.where(id: params[:id], job_status: "Completed"))
      rescue => e
        logger.info e
        render json: { message: 'job id not found' }, status: :not_found
      end

      # Only allow a trusted parameter "white list" through.
      def job_params
        params.require(:job).permit(:pick_up_date, :delivery_date, :is_flat_rate, :is_confirmed_by_customer, :is_confirmed_by_manager, :storage_fee, :job_duration, :job_size, :job_status, :start_time, :crew_size, :job_rate, :estimated_time, :travel_time, :time_between, :estimated_quote, :additional_info, :total_amount, :job_type, :customer_id, :deposit, :is_deposit_paid)
      end
  end
end
