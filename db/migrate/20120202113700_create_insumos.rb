class CreateInsumos < ActiveRecord::Migration
  def change
    create_table :insumos do |t|
      t.integer :crudoProcesado
      t.integer :leniaCaldera
      t.integer :carbonActivado
      t.integer :auxiliarDeFiltracion
      t.integer :turno_dia_id

      t.timestamps
    end
  end
end
