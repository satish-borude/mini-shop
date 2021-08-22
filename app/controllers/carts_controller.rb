class CartsController < ApplicationController 
	# before_action :authorized, only: [:cart_checkout] 	
  # Ensures that the cart_id parameter exists in the request
  # and that the cart_id exists in the Cart table

 # POST   /api/v1/carts
  def create
    cart = Cart.create!
    render json: { status: 'SUCCESS', message: 'Cart created.', cart: cart }, status: :created
  end

 # GET    /api/v1/carts/:cart_id
  def show
    validate_cart_id
    cart = Cart.find(params[:cart_id])
    render json: { status: 'SUCCESS', message: 'Loaded cart content', cart_content: cart.cart_items,  subtotal: cart.calculate_subtotal }, status: :ok
  end


  def cart_checkout
    # validate_user_id
    if params[:user_id].present?
	    validate_cart_id
	    cart = Cart.find(params[:cart_id])
	    checkout_successful = cart.checkout(@user.id)
	    unless checkout_successful
	      raise ActionController::BadRequest, 'Checkout could not be'\
	       ' completed. Some products might be out of stock or the'\
	       ' cart is empty.'
	    end
      render json: { status: 'SUCCESS', message: 'Checkout successful.' }, status: :ok
    elsif params[:email] && params[:password] 
    	  @user = User.find_by(email: params[:email])
  	  if @user && @user.authenticate(params[:password])
	      token = encode_token({user_id: @user.id})
	      checkout_successful = @user.cart.checkout(@user.id)
	      render json: {token: token,  status: 'SUCCESS', message: 'Checkout successful.' }, status: :ok
	    else
	      render json: {error: "Invalid username or password"}
	    end	
	  else  
    	 raise ActionController::BadRequest, 'Login first'\
       ' Send User Credential'
    end     
  end


 private
  # Only allow a trusted parameter "white list" through.
	def cart_params
	  params.require(:cart).permit(:id, :user_id)
	end 
end 