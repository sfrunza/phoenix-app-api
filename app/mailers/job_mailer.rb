class JobMailer < ApplicationMailer
    default from: 'Brave Movers'

    def send_confirm_availability(job)
      @customer = params[:customer]
      @password = @customer.first_name[0] + @customer.last_name[0] + @customer.phone.split(//).last(4).join
      @job = job
      @login_url  = 'https://www.bravemovers.com/login'
      @origin = params[:job].addresses.select { |n| n.is_origin }
      @destination = params[:job].addresses.select { |n| n.is_destination }
      mail(to: @customer.email, subject: 'GREAT NEWS! Your requested moving date is AVAILABLE!')
    end

    def send_an_follow_up(job)
      @customer = params[:customer]
      @job = job
      @login_url  = 'https://www.bravemovers.com/login'
      mail(to: @customer.email, subject: 'Brave Movers - Just following up on your moving request')
    end

    def send_moving_confirmation(job)
      @customer = params[:customer]
      @job = job
      @origin = params[:job].addresses.select { |n| n.is_origin }
      @destination = params[:job].addresses.select { |n| n.is_destination }
      mail(to: @customer.email, subject: 'You are all set! Your move is booked and scheduled')
    end

    def send_permit_information(job)
      @customer = params[:customer]
      @job = job
      @parking_url  = 'https://www.boston.gov/reserve-parking-spot-your-moving-truck#:~:text=Apply%20for%20and%20pick%20up,be%20an%20actual%20parking%20space'
      attachments.inline['permit.png'] = File.read(Rails.root.join("app/assets/permit.png"))
      mail(to: @customer.email, subject: 'Brave Movers - tips & tricks')
    end

    def send_survival_box_information(job)
      @customer = params[:customer]
      @job = job
      mail(to: @customer.email, subject: 'Brave Movers - tips & tricks')
    end

    def send_moving_receipt(job)
      @customer = params[:customer]
      @job = job
      mail(to: @customer.email, subject: 'Brave Movers - Moving Receipt')
    end

    def send_next_day_move_reminder(job)
      @customer = params[:customer]
      @job = job
      mail(to: @customer.email, subject: 'Ready for upcoming move?')
    end

    def ask_for_review(job)
      @customer = params[:customer]
      @job = job
      mail(to: @customer.email, subject: 'Your feedback is important to us')
    end  

    def deposit_paid(job)
      @customer = params[:customer]
      @job = job
      mail(to: "info@bravemovers.com", subject: 'Deposit Paid')
    end  
  end
  