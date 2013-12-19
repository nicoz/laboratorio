class AddDiaFinalizadoToDia < ActiveRecord::Migration
  def change
    add_column :dia, :dia_finalizado, :boolean, :default => false

  end
end
