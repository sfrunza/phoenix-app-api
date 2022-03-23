class CustomerregistrationsController < Devise::RegistrationsController

    def create
      @customer = Customer.new(customer_params)
      if defined?((customer_params[:email]))
        @old_customer= Customer.find_by_email!(customer_params[:email])
        sign_in :customer, @old_customer
        redirect_to api_v1_customers_path
      elsif @customer.save
        render json: @customer
      else
        warden.custom_failure!
        render json: { error: 'signup error' }, status: :unprocessable_entity
      end
    end
  
    def update
      @customer = Customer.find_by_email(customer_params[:email])
  
      if update_resource(@customer, customer_params)
        bypass_sign_in(@customer)
      else
        warden.custom_failure!
        render :json=> @customer.errors, :status=>422
      end
   end
  
    def destroy
      @customer = Customer.find_by_email(customer_params[:email])
      if @customer.destroy
        render :json=> { success: 'user was successfully deleted' }, :status=>201
      else
        render :json=> { error: 'user could not be deleted' }, :status=>422
      end
    end
  
    private
  
    def customer_params
       params.require(:customer).permit(:email, :password, :password_confirmation, :current_password)
    end
  end
  