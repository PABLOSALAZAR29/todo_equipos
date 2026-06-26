require "test_helper"

class CommentTest < ActiveSupport::TestCase

  test "un comentario con contenido es válido" do
    comment = comments(:one)
    assert comment.valid?
  end

  test "un comentario sin contenido no es válido" do
    # Arrange
    comment = Comment.new(
      content: "",       # contenido vacío
      task: tasks(:one),
      user: users(:one)
    )

    # Assert
    assert_not comment.valid?, "Un comentario vacío no debería ser válido"
  end

  test "un comentario pertenece a un usuario" do
    comment = comments(:one)
    assert_not_nil comment.user
  end

  test "un comentario pertenece a una tarea" do
    comment = comments(:one)
    assert_not_nil comment.task
  end

  test "los comentarios se ordenan del más reciente al más antiguo" do
    task = tasks(:one)

    # El primer comentario de la colección debería ser el más reciente
    # El default_scope en el modelo ordena por created_at: :desc
    first = task.comments.first
    last = task.comments.last

    assert first.created_at >= last.created_at,
      "Los comentarios deberían ordenarse del más reciente al más antiguo"
  end
end