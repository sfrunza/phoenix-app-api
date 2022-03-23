# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  User.create!(email: 'frunza.sergiu3@gmail.com', password: '111111', password_confirmation: '111111', admin: true, first_name: 'Sergiu', last_name: 'Frunza')
  User.create!(email: 'slavic.frunza@gmail.com', password: '111111', password_confirmation: '111111', admin: true, first_name: 'Slavic', last_name: 'Frunza')
  User.create!(email: 'tomac.daniel@gmail.com', password: '111111', password_confirmation: '111111', admin: true, first_name: 'Daniel', last_name: 'Tomac')

  Price.create!(two_men: [100, 120, 140], three_men: [140, 160, 180], four_men: [180, 200, 220], add_men: [40, 40, 40], add_truck: [30, 30, 30])


  # 300.times {
  #   min_date = Time.now
  #   max_date = Time.now + 1.year
  #   all = User.all
  #   user = User.find(id = rand(all.length)+1)
  #   Job.create(user_id: user.id, pick_up_date: rand(min_date..max_date), job_size: "1 Bedroom apartment", job_type: "Moving", crew_size: 3, job_rate: 200, estimated_time: [6,7], travel_time: [20, 20], estimated_quote: [1200, 1400], job_status: 'Confirmed')
  # }

  # 300.times {
    
  #   all = Job.all
  #   job = Job.find(id = rand(all.length)+1)
  #   Origin.create(job_id: job.id, address: "2 Main St", city: "Dedham", state: "MA", zip: "02026", floor: "3rd floor")
  # }

  # 300.times {
  #   all = Job.all
  #   job = Job.find(id = rand(all.length)+1)
  #   Destination.create(job_id: job.id, address: "7 Washington St", city: "Brookline", state: "MA", zip: "02446", floor: "4th floor")
  # }