class AddOrdenToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :orden, :integer

  end
end
