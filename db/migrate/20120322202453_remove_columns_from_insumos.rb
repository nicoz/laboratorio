class RemoveColumnsFromInsumos < ActiveRecord::Migration
  def up
  	remove_column :insumos, :leniaCaldera
  	remove_column :insumos, :carbonActivado
  	remove_column :insumos, :auxiliarDeFiltracion
  	remove_column :insumos, :piedra_de_cal
  	remove_column :insumos, :chip
  	remove_column :insumos, :aserrin
  end

  def down
  end
end
