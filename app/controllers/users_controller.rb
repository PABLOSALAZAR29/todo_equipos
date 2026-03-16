class UsersController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]   # permite acceso sin login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Inicia sesión automáticamente después de registrarse
      session = @user.sessions.create!(ip_address: request.remote_ip, user_agent: request.user_agent)
      cookies.signed[:session_token] = { value: session.token, expires: 2.weeks.from_now }
      redirect_to root_path, notice: "¡Cuenta creada! Bienvenid@."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end