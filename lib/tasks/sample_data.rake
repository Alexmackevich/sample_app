namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Mackevich Alexey",
                       email:    "41exmackevich@gmail.com",
                       password: "3021257",
                       password_confirmation: "3021257")
  admin.toggle!(:admin)
  # 9.times do |n|
  #   name  = Faker::Name.name
  #   email = "example-#{n+1}@railstutorial.org"
  #   password  = "password"
  #   User.create!(name:     name,
  #                email:    email,
  #                password: password,
  #                password_confirmation: password)
  # end
end

# def make_microposts
#   users = User.all
#   5.times do
#     content = Faker::Lorem.sentence(5)
#     users.each { |user| user.microposts.create!(content: content) }
#   end
# end

# def make_relationships
#   users = User.all
#   user  = users.first
#   followed_users = users[2..5]
#   followers      = users[3..8]
#   followed_users.each { |followed| user.follow!(followed) }
#   followers.each      { |follower| follower.follow!(user) }
# end