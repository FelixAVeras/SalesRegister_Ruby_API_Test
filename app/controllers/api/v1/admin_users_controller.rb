class Api::V1::AdminUsersController < ApplicationController
  before_action :set_admin_user, only: [:show, :update, :destroy]

  def index
    admins = User.where(role: 'admin')
    render json: admins
  end

  def show
    render json: @admin_user
  end

  def create
    admin = User.new(admin_user_params)
    admin.role = 'admin'
    if admin.save
      render json: admin, status: :created
    else
      render json: { errors: admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @admin_user.update(admin_user_params)
      render json: @admin_user
    else
      render json: { errors: @admin_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_user.destroy
    head :no_content
  end

  private

  def set_admin_user
    @admin_user = User.find(params[:id])
  end

  def admin_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
