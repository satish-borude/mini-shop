class CartItemsController < ApplicationController
	  # before_action :authorized, only: [:auto_login]

   def create
      # ensures that all the required parameters are there and exist
      # in the database.
      validate_product_id
      validate_cart_id
      validate_item_quantity
      cart = Cart.find(params[:cart_id])
      cart.add_product(params[:product_id], params[:item_quantity])
      render json: { status: 'SUCCESS', message: 'Item added to cart.' }, status: :created
    end

    # Updates the quantity for an item in a cart
    # PUT    {{url}}/carts/:cart_id/cart_items/:product_id
    # PATCH  {{url}}/carts/:cart_id/cart_items/:product_id
    # body ex:
    # {
    #   "item_quantity": 5
    # }
    def update
      # ensures that all the required parameters are there and exist
      # in the database
      validate_product_id
      validate_cart_id
      validate_item_quantity
      cart = Cart.find(params[:cart_id])
      cart.update_cart_item(params[:product_id], params[:item_quantity])
      render json: { status: 'SUCCESS', message: 'Item quantity updated.' }, status: :ok
    end

    # Removes an item from a cart. If the item doesn't exist or the cart
    # doesn't exist then an error is raised
    # DELETE {{url}}/carts/:cart_id/cart_items/:product_id
    def destroy
      # ensures that all the required parameters are there and exist
      # in the database
      validate_product_id
      validate_cart_id
      validate_cart_item
      cart_item = CartItem.find_by!(product_id: params[:product_id], cart_id: params[:cart_id])
      cart_item.destroy!
      render json: { status: 'SUCCESS', message: 'Item removed from cart.' }, status: :ok
    end



    private

    # Ensures the item quantity is passed with the request
    def validate_item_quantity
      params.require(:item_quantity)
    end

    # Ensures that the item exists in the cart
    def validate_cart_item
      cart_item = CartItem.find_by(product_id: params[:product_id])
      if cart_item.nil?
        raise ArgumentError, 'The item does not exist in the cart'
      end
    end

end
