class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  before_action :set_user, only: %i[ show update destroy ]

  def create
    @user = User.new(
      login: user_params[:login],
      password: user_params[:password],
      name: user_params[:name],
      avatar: user_params[:avatar],
    )

    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def user_url(arg)
    return '/projects'
  end

  def login
    @user = User.find_by(login: params[:login])

    puts @user
    puts @user.authenticate(params[:password])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: "Invalid login or password" }
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

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:login, :password, :name, :avatar)
    end
end
