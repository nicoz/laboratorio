class CreateClientePedidoProduccions < ActiveRecord::Migration
  def change
    create_table :cliente_pedido_produccions do |t|
      t.integer :cliente_id
      t.integer :pedido_produccion_id
      t.float :azucar_big_bag

      t.timestamps
    end
  end
end
