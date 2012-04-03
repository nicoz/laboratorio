class AddDiaIdToInsumoDiarios < ActiveRecord::Migration
  def change
    add_column :insumo_diarios, :dia_id, :integer
  end
end
