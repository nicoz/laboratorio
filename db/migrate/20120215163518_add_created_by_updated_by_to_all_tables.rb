class AddCreatedByUpdatedByToAllTables < ActiveRecord::Migration
  def change
	add_column :usuarios, :updated_by, :integer
	add_column :usuarios, :created_by, :integer
	add_column :dia, :updated_by, :integer
	add_column :dia, :created_by, :integer
	add_column :insumos, :updated_by, :integer
	add_column :insumos, :created_by, :integer
	add_column :turno_dia, :updated_by, :integer
	add_column :turno_dia, :created_by, :integer
	add_column :turnos, :updated_by, :integer
	add_column :turnos, :created_by, :integer
  end
end
