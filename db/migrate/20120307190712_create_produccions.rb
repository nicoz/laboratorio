class CreateProduccions < ActiveRecord::Migration
  def change
    create_table :produccions do |t|
      t.decimal :paquetesPapel
      t.decimal :paquetesPolietileno
      t.decimal :melaza
      t.decimal :rubio
      t.decimal :industriaBolsas
      t.decimal :bolsasAzucarlito
      t.decimal :bigBagAzucarlito
      t.decimal :bigBagDnd
      t.decimal :bigBagClientes
      t.integer :turno_dia_id

      t.timestamps
    end
  end
end
