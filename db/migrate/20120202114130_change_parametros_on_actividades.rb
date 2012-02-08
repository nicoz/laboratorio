class ChangeParametrosOnActividades < ActiveRecord::Migration
	def change
		change_column :actividads, :parametros, :text
	end
end
