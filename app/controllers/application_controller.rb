class ApplicationController < ActionController::API
	before_action :authorized!, :only => [:new]
  
  def validate_user_id
    params.require(:user_id)
    user_id = params[:user_id].to_i 
    raise ArgumentError, 'User not found login first.' unless User.exists?(user_id)
  end 

  def validate_cart_id
    params.require(:cart_id)
    cart_id = params[:cart_id].to_i # prevents SQL injection
    raise ArgumentError, 'Cart not found.' unless Cart.exists?(cart_id)
  end

      # Ensures that the product_id parameter exists in the request
  # and that the product_id exists in the Product table
  def validate_product_id
    params.require(:product_id)
    product_id = params[:product_id].to_i 
    unless Product.exists?(product_id)
      raise ArgumentError, 'Product not found. The product might'\
       ' not exist or has been deleted.'
    end
  end


	def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

end
