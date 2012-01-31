class CreateTurnos < ActiveRecord::Migration
  def change
    create_table :turnos do |t|
      t.string :nombre
      t.boolean :habilitado

      t.timestamps
    end
  end
end
