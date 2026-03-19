class AddCedulaToPerfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :perfils, :cedula, :string
  end
end
