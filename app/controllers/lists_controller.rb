class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = Current.user.lists.order(created_at: :desc)
  end

  def show
    @tasks = @list.tasks.order(:position)
  end

  def new
    @list = Current.user.lists.build
  end

  def create
    @list = Current.user.lists.build(list_params)

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
    @list = Current.user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end