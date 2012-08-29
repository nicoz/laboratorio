class ChangeObservacionesToTextInDia < ActiveRecord::Migration
  def up
    change_table :dia do |t|
      t.change :observaciones, :text
    end

  end

  def down
    change_table :dia do |t|
      t.change :observaciones, :string
    end
  end
end
