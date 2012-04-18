class CreateRecepcions < ActiveRecord::Migration
  def change
    create_table :recepcions do |t|
      t.integer :azucar_crudo
      t.decimal :polarizacion
      t.decimal :perdida_en_azucar
      t.decimal :azucar_en_melaza
      t.integer :dia_id

      t.timestamps
    end
  end
end
