class RemoveEncaladoBeFromAnalisis < ActiveRecord::Migration
  def up
    remove_column :analises, :encalado_be
  end

  def down
  end
end
