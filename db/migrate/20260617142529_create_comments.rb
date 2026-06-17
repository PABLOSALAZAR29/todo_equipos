class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      # content:text permite textos largos (más que string)
      t.text :content

       # references crea automáticamente task_id y user_id
      # con sus índices y foreign keys
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
