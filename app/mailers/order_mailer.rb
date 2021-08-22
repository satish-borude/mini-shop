class OrderMailer < ApplicationMailer
	 def new_order_genrated_email(order)
     order
    mail(to: 'satishborude19@gmail.com', subject: "You got a new order!")
  end
end
