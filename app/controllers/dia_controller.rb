class DiaController < ApplicationController

	def dias
		if !params[:fecha].nil?
			fecha = Date.parse(params[:fecha])
			inicio = (fecha.to_time - 45.days).to_date
			fin = (fecha.to_time + 45.days).to_date
		
			respuesta = []
			
			numerador = TurnoDia.count()
			inicio.upto(fin) do |dia|
				turnos = Turno.find(:all, :conditions => {:habilitado => true}, :order => 'orden')
			
				
				turnos.each do |turno|
					encontrado = false
					turnosDias = TurnoDia.find(:all, :joins => [:turno, :dia],
								:conditions => {:dia => {:fecha => dia},
										:turnos => {:id => turno } })
					turnosDias.each do |turnoDia|
						encontrado = true
						fondo = '#006600' if turnoDia.estado == 'Cerrado'
						fondo = '#330099' if turnoDia.estado == 'Abierto'
						fondo = '#B80000' if turnoDia.estado =='Anulado'
						texto = 'white' if 
							['Abierto', 'Cerrado', 'Anulado'].include? turnoDia.estado 
						elemento = {:id => turnoDia.id, :title => turnoDia.turno.nombre, 
								:url => ver_turno_dia_path(turnoDia.dia.fecha,
									turnoDia.turno.nombre),
								:start => turnoDia.dia.fecha,
								:className => 'evento-activo',
								:backgroundColor => fondo,
								:borderColor => fondo,
								:textColor => texto
								}
						respuesta << elemento
					end
				
					if !encontrado
						fondo = '#CCCCCC'
						texto = 'white'
						elemento = {:id => numerador, :title => turno.nombre, 
								:url => ver_turno_dia_path(dia,
									turno.nombre),
								:start => dia,
								:className => 'evento-activo',
								:backgroundColor => fondo,
								:borderColor => fondo,
								:textColor => texto
								}
						respuesta << elemento
					end
				end
			end
		
			respond_to do |format|
				format.json { render json: respuesta }
			end
		end
	end
	
end
