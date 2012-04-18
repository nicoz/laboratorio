class AddTirajeToInsumos < ActiveRecord::Migration
  def change
    add_column :insumos, :tiraje, :integer

  end
end
