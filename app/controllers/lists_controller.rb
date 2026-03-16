class ListsController < ApplicationController
  before_action :authenticate
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = current_user.lists.order(created_at: :desc)
  end

  def new
    @list = current_user.lists.build
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      redirect_to lists_path, notice: "Lista creada exitosamente."
    else
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
    @list = current_user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end