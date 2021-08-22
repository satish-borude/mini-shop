class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login] 
  before_action :set_user, only: [:show, :update, :destroy, :orders]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def orders
    if params[:from_date].present? && params[:to_date].present?
      User.joins(:orders).where('created_at BETWEEN ? AND ?', Date.parse(params[:from_date]).beginning_of_day, Date.parse(params[:to_date]).end_of_day) || []
    else 
       User.includes(:orders).find(params[:id])
    end
    render json: { status: 'SUCCESS', message: 'Item added to cart.', orders:  @user.orders  }
  end 
  # ------------------------------------------
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user.as_json.merge({'cart_id'=>@user.cart.id }),  token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {})
    end
end
