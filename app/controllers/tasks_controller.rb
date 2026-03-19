class TasksController < ApplicationController
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_list
  before_action :set_task, only: [:edit, :update, :destroy, :toggle_completed]

  def index
    @tasks = @list.tasks
  end

  def new
    @task = @list.tasks.build
  end

  def create
    @task = @list.tasks.build(task_params)
    if @task.save
      redirect_to @list, notice: "Tarea creada correctamente."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @list, notice: "Tarea actualizada."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to @list, notice: "Tarea eliminada."
  end

  def toggle_completed
    @task.update(completed: !@task.completed)
    redirect_to @list, notice: "Estado de la tarea actualizado."
  end

  private

  def set_list
    if Current.user.admin?
        @list = List.find(params[:list_id])      # admin ve todas las listas
    else
        @list = Current.user.lists.find(params[:list_id])  # usuario solo ve las suyas
    end
   end

  def set_task
    @task = @list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end