class UserMailer < ApplicationMailer
  default from: 'Brave Movers'
  default :template_path => '/user_mailer'

  def welcome_email
    @customer = params[:customer]
    @login_url  = 'https://www.bravemovers.com/login'
    @password = @customer.first_name[0] + @customer.last_name[0] + @customer.phone.split(//).last(4).join
    mail(to: @customer.email, subject: 'Welcome to Brave Movers')
  end

  def new_job_email
    @customer = params[:customer]
    @job = params[:job]
    mail(to: "info@bravemovers.com", subject: 'New Job Submitted')
  end

end
