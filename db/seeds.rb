require 'random_data'

# require 'faker'
# include Faker


# Create Users
5.times do
    User.create!(
        #name: RandomData.random_name,
        email: RandomData.random_email,
        password: RandomData.random_sentence
        )
end
    
# Create admin user
unless User.find_by(email: 'admin@example.com')
    User.create!(
        # name: 'Admin User',
        email: 'admin@example.com',
        password: 'helloworld',
        #role: 'admin'
        )
end

unless User.find_by(email: 'member@example.com')
    User.create!(
        #name: 'Member User',
        email: 'member@example.com', 
        password: 'helloworld'
        )
end

users = User.all

puts "#{User.count} users created"


# Creates wikis
10.times do 
    Wiki.create!(
        user: users.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
        )
end
wikis = Wiki.all



puts "#{Wiki.count} wikis created"
puts "Seed finished"