class Comment < ApplicationRecord
  # Un comentario pertenece a una tarea
  belongs_to :task

  # Un comentario pertenece al usuario que lo escribió
  belongs_to :user

  # El contenido no puede estar vacío
  validates :content, presence: true

  # Ordena los comentarios del más reciente al más antiguo
  # default_scope aplica este orden en todas las consultas
  default_scope { order(created_at: :desc) }
end