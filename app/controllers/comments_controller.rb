class CommentsController < ApplicationController
  # set_task carga la lista y la tarea antes de cada acción
  before_action :set_task

  def create
    # Construye el comentario asociado a la tarea y al usuario actual
    @comment = @task.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      # Responde con formato Turbo Stream en lugar de HTML normal
      # Esto le dice a Rails que busque create.turbo_stream.erb
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to list_task_path(@list, @task) }
      end
    else
      # Si hay error redirige de vuelta
      redirect_to list_task_path(@list, @task),
        alert: "El comentario no puede estar vacío."
    end
  end

  def destroy
    @comment = @task.comments.find(params[:id])

    # Solo el autor del comentario o un admin puede borrarlo
    if @comment.user == Current.user || Current.user.admin?
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to list_task_path(@list, @task) }
      end
    else
      redirect_to list_task_path(@list, @task),
        alert: "No tienes permiso para borrar este comentario."
    end
  end

  private

  def set_task
    # Necesitamos cargar la lista primero porque las rutas son anidadas
    # /lists/:list_id/tasks/:task_id/comments
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end