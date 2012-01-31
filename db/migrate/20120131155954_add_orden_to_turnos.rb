class AddOrdenToTurnos < ActiveRecord::Migration
  def change
    add_column :turnos, :orden, :integer
  end
end
