class CreatePedidoProduccions < ActiveRecord::Migration
  def change
    create_table :pedido_produccions do |t|
      t.integer :dia_id
      t.float :paquetesPapel
      t.float :paquetesPolietileno
      t.float :industriaBolsas
      t.float :bolsasAzucarlito
      t.float :bigBagAzucarlito
      t.string :bigBagDnd

      t.timestamps
    end
  end
end
