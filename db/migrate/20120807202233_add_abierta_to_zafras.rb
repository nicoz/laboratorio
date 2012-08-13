class AddAbiertaToZafras < ActiveRecord::Migration
  def change
    add_column :zafras, :abierta, :boolean, :default => true

  end
end
