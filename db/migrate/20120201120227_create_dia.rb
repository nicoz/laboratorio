class CreateDia < ActiveRecord::Migration
  def change
    create_table :dias do |t|
      t.date :fecha
      t.boolean :activo

      t.timestamps
    end
  end
end
