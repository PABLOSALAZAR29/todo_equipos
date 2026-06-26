require "test_helper"

class TaskTest < ActiveSupport::TestCase

  # ============================================
  # TESTS DE VALIDACIONES
  # Verifican que las reglas del modelo funcionan
  # ============================================

  test "una tarea con título es válida" do
    # Arrange — creamos una tarea con datos mínimos válidos
    # tasks(:one) carga el fixture "one" de tasks.yml
    task = tasks(:one)

    # Assert — verificamos que es válida
    assert task.valid?, "La tarea debería ser válida si tiene título"
  end

  test "una tarea sin título no es válida" do
    # Arrange — creamos una tarea sin título
    task = Task.new(title: "", list: lists(:one))

    # Assert — verificamos que NO es válida
    assert_not task.valid?, "La tarea no debería ser válida sin título"
  end

  test "una tarea sin título tiene error en el campo title" do
    task = Task.new(title: "", list: lists(:one))
    task.valid? # ejecutamos las validaciones

    # Verificamos que el error está específicamente en :title
    assert_includes task.errors[:title], "can't be blank"
  end

  # ============================================
  # TESTS DE ASOCIACIONES
  # Verifican que las relaciones entre modelos funcionan
  # ============================================

  test "una tarea pertenece a una lista" do
    task = tasks(:one)

    # Verificamos que tiene una lista asociada
    assert_not_nil task.list, "La tarea debería tener una lista"
  end

  test "una tarea puede tener comentarios" do
    task = tasks(:one)

    # El fixture de comments tiene dos comentarios para task one
    assert_equal 2, task.comments.count
  end

  test "al borrar una tarea se borran sus comentarios" do
    task = tasks(:one)

    # assert_difference verifica que el contador cambia en -2
    # porque task one tiene 2 comentarios en los fixtures
    assert_difference "Comment.count", -2 do
      task.destroy
    end 
  end

  # ============================================
  # TESTS DE COMPORTAMIENTO
  # Verifican que la lógica del modelo funciona
  # ============================================

  test "una tarea nueva no está completada por defecto" do
    task = Task.new(title: "Nueva tarea", list: lists(:one))

    # El default en la migración es false
    assert_not task.completed?, "Una tarea nueva no debería estar completada"
  end

  test "se puede marcar una tarea como completada" do
    task = tasks(:one)
    task.update(completed: true)

    assert task.completed?, "La tarea debería estar completada"
  end
end