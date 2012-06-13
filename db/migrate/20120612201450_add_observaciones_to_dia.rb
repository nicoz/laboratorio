class AddObservacionesToDia < ActiveRecord::Migration
  def change
    add_column :dia, :observaciones, :string

  end
end
