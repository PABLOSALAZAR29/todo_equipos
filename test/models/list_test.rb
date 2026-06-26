require "test_helper"

class ListTest < ActiveSupport::TestCase

  test "una lista con título es válida" do
    list = lists(:one)
    assert list.valid?
  end

  test "una lista pertenece a un usuario" do
    list = lists(:one)
    assert_not_nil list.user
  end

  test "al borrar una lista se borran sus tareas" do
    list = lists(:one)

    # lists(:one) tiene 2 tareas en los fixtures (one y completada)
    assert_difference "Task.count", -2 do
      list.destroy
    end
  end
end