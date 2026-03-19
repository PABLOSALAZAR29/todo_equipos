class CreatePerfils < ActiveRecord::Migration[8.0]
  def change
    create_table :perfils do |t|
      t.references :user, null: false, foreign_key: true
      t.string :primer_nombre
      t.string :segundo_nombre
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :celular
      t.string :ciudad
      t.string :departamento
      t.string :direccion
      t.string :cargo

      t.timestamps
    end
  end
end
