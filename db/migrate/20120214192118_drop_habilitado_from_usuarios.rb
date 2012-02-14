class DropHabilitadoFromUsuarios < ActiveRecord::Migration
  def up
  	remove_column :usuarios, :habilitado
  end

  def down
  end
end
