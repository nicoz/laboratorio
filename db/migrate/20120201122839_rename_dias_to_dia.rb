class RenameDiasToDia < ActiveRecord::Migration
  def up
  	rename_table :dias, :dia
  end

  def down
  	rename_table :dia, :dias
  end
end
