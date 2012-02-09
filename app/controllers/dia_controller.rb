class DiaController < ApplicationController

	def dias
		if !params[:fecha].nil?
			fecha = Date.parse(params[:fecha])
			inicio = (fecha.to_time - 45.days).to_date
			fin = (fecha.to_time + 45.days).to_date
			
			@dias = Dia.where("fecha >= ? and fecha <= ?", inicio, fin)
		else
			@dias = Dia.all
		end
		
		respuesta = []
		@dias.each do |dia|
			dia.turnos.each do |turno|
				fondo = '#006600' if turno.estado == 'Cerrado'
				fondo = '#330099' if turno.estado == 'Abierto'
				fondo = '#B80000' if turno.estado =='Anulado'
				texto = 'white' if ['Abierto', 'Cerrado', 'Anulado'].include? turno.estado 
				elemento = {:id => turno.id, :title => turno.turno.nombre, 
						:url => ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre),
						:start => turno.dia.fecha,
						:className => 'evento-activo',
						:backgroundColor => fondo,
						:borderColor => fondo,
						:textColor => texto
						}
				respuesta << elemento
			end
		end
		
		respond_to do |format|
			format.json { render json: respuesta }
		end
	end
	
end
