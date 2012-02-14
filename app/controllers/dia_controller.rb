class DiaController < ApplicationController
	before_filter :autenticar, 		:only => [:show, :dias]
	
	add_breadcrumb 'Escritorio', '/escritorio'
	
	def show
		if params[:fecha].nil?
			flash[:error] = "Debe ingresar una fecha correcta"
			redirect_to escritorio_path
		else
			fecha = Date.parse(params[:fecha])
			@dia = Dia.find_or_create_by_fecha(fecha)
			
			turnos = Turno.find(:all, :conditions => {:habilitado => true}, :order => 'orden')
			@turnos_dia = []
			turnos.each do |turno|
				td = TurnoDia.find_by_dia_id_and_turno_id(@dia, turno)
				
				if td.nil?
					td = @dia.turnos.build(:estado => "Abierto")
					td.turno = turno
				end 
				@turnos_dia << td
			end
		end

		add_breadcrumb "#{l @dia.fecha}", @dia
	end

	def dias
		if !params[:fecha].nil?
			fecha = Date.parse(params[:fecha])
			inicio = (fecha.to_time - 45.days).to_date
			fin = (fecha.to_time + 45.days).to_date
		
			respuesta = []
			
			#turnosDias = TurnoDia.find(:all, :joins => [:turno, :dia],
			#		:conditions => {:dia => {:fecha => dia},
			#				:turnos => {:id => turno } })
			numerador = TurnoDia.count()
			turnosDias = TurnoDia.joins([:dia, :turno]).where("fecha >= ? and fecha <= ?", inicio, fin).order('orden')
			turnos = Turno.find(:all, :conditions => {:habilitado => true}, :order => 'orden')
			inicio.upto(fin) do |dia|
				segundos = 0
				turnos.each do |turno|
					encontrado = false
					turnosDias.each do |turnoDia|
						if turnoDia.turno == turno and turnoDia.dia.fecha == dia
							encontrado = true
							segundos = segundos + 1
							fondo = '#006600' if turnoDia.estado == 'Cerrado'
							fondo = '#330099' if turnoDia.estado == 'Abierto'
							fondo = '#B80000' if turnoDia.estado =='Anulado'
							texto = 'white' if 
								['Abierto', 'Cerrado', 'Anulado'].include? turnoDia.estado 
							elemento = {:id => turnoDia.id, :title => turnoDia.turno.nombre, 
									:url => ver_turno_dia_path(turnoDia.dia.fecha,
										turnoDia.turno.nombre),
									:start => (turnoDia.dia.fecha.to_time + segundos.seconds),
									:className => 'evento-activo',
									:backgroundColor => fondo,
									:borderColor => fondo,
									:textColor => texto
									}
							respuesta << elemento
						end
					end
				
					if !encontrado
						segundos = segundos + 1
						numerador = numerador + 1
						fondo = '#CCCCCC'
						texto = 'white'
						elemento = {:id => numerador, :title => turno.nombre, 
								:url => ver_turno_dia_path(dia,
									turno.nombre),
								:start => (dia.to_time + segundos.seconds),
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
