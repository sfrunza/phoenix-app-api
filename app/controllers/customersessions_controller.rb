class CustomersessionsController < Devise::SessionsController

    # POST /v1/login
    def create
      @customer = Customer.find_by_email(customer_params[:email])
      return invalid_login_attempt unless @customer
  
      if @customer.valid_password?(customer_params[:password])
        sign_in :customer, @customer
        redirect_to api_v1_customers_path
      else
        render json: {
          status: 401,
          errors: ['Invalid password']
        }
      end
  
    end
  
    def destroy
      @customer = Customer.find(current_customer.id)
      sign_out(@customer)
      render :json=> {:success=>true}
  
    end
  
  
    private
  
    def invalid_login_attempt
      warden.custom_failure!
      # render json: {error: ['No such user!', ' Verify credentials and try again']}, status: :unprocessable_entity
      render json: {
        status: :unprocessable_entity,
        errors: ['No such user!', ' Verify credentials and try again']
      }
    end
  
    def customer_params
       params.require(:customer).permit(:email, :password, :active)
    end
  
  end
  