# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
		Product.destroy_all
		User.destroy_all
		# Product.create([{ name: 'Star Wars', quantity: 4 }, { name: 'Lord of the Rings', quantity: 4 } , { name: 'Lord of the Ring2s', quantity: 4 }])
		User.create([{ username: 'user_one', password: 'password1', email: 'user1@shop.com' }, 
			           { username: 'user_two', password: 'password2', email: 'user2@shop.com' } , 
			           { username: 'user_three', password: 'password3', email: 'user3@shop.com' }])

		20.times do 
		  product = Product.create(name: Faker::Lorem.word, quantity: Faker::Number.decimal_part(digits: 2), price: Faker::Number.decimal(l_digits: 3, r_digits: 2), ratings: Faker::Number.decimal_part(digits: 1))
		  product.image.attach(io: File.open(Rails.public_path.join('product1.jpg')), filename: 'product1.jpg')
	  end

