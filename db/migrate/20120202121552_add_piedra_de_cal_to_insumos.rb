class AddPiedraDeCalToInsumos < ActiveRecord::Migration
  def change
  	add_column :insumos, :piedra_de_cal, :integer
  end
end
