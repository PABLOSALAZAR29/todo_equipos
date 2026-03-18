class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if Current.user.admin?
      @users_with_lists = User.includes(lists: :tasks).order(:email_address)
    else
      @lists = Current.user.lists.order(created_at: :desc)
    end
  end

  def show
    @tasks = @list.tasks.order(:position)
  end

  def new
    @users = User.order(:email_address) if Current.user.admin?
    @list = List.new
  end

  def create
    user = if Current.user.admin? && params[:list][:user_id].present?
      User.find(params[:list][:user_id])
    else
      Current.user
    end
    @list = user.lists.build(list_params)

    if @list.save
      redirect_to lists_path, notice: "Lista creada exitosamente."
    else
      @users = User.order(:email_address) if Current.user.admin?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path, notice: "Lista actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: "Lista eliminada."
  end

  private

  def set_list
    @list = if Current.user.admin?
      List.find(params[:id])
    else
      Current.user.lists.find(params[:id])
    end
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
