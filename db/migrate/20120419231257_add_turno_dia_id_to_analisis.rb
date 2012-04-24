class AddTurnoDiaIdToAnalisis < ActiveRecord::Migration
  def change
    add_column :analises, :turnoDia_id, :integer

  end
end
