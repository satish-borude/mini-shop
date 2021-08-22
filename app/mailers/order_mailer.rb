class OrderMailer < ApplicationMailer
	 def new_order_genrated_email(user,order)
    user.email
    mail(to: user.email, subject: "You got a new order!")
  end
end
