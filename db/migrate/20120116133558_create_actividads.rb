class CreateActividads < ActiveRecord::Migration
  def change
    create_table :actividads do |t|
      t.integer :usuario_id
      t.string :controlador
      t.string :accion
      t.string :parametros

      t.timestamps
    end
  end
end
