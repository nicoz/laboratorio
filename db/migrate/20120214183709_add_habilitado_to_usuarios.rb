class AddHabilitadoToUsuarios < ActiveRecord::Migration
  def change
  	add_column :usuarios, :habilitado, :boolean
  end
end
