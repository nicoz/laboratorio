class CreateProduccionMasas < ActiveRecord::Migration
  def change
    create_table :produccion_masas do |t|
      t.integer :numero_masas_a
      t.integer :numero_masas_b
      t.integer :numero_masas_c
      t.integer :numero_masas_d
      t.integer :dia_id

      t.timestamps
    end
  end
end
