class HabilitarDiasPasados < ActiveRecord::Migration
  def up
    Dia.where('fecha < ?', Date.today).each do |dia|
      dia.dia_finalizado = true
      dia.save()
    end
  end

  def down
  end
end
