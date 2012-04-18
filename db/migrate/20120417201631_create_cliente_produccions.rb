class CreateClienteProduccions < ActiveRecord::Migration
  def change
    create_table :cliente_produccions do |t|
      t.integer :produccion_id
      t.integer :cliente_id
      t.integer :azucar_big_bag

      t.timestamps
    end
  end
end
