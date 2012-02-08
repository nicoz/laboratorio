class AddChipToInsumo < ActiveRecord::Migration
  def change
  	add_column :insumos, :chip, :integer
  end
end
