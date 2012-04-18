class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.boolean :habilitado, :default => true

      t.timestamps
    end
  end
end
