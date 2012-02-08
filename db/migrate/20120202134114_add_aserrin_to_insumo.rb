class AddAserrinToInsumo < ActiveRecord::Migration
  def change
  	add_column :insumos, :aserrin, :integer
  end
end
