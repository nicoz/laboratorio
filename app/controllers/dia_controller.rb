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
			inicio.upto(fin) do |dia|
				segundos = 0
				segundos = segundos + 1
				fondo = '#006600' if dia < Time.now.to_date
				fondo = '#330099' if dia == Time.now.to_date
				fondo = '#B80000' if dia > Time.now.to_date
				texto = 'white' 
				insumos = {:id => segundos, :title => 'Insumos por turno', 
						:url => crear_insumo_path(dia),
						:start => (dia.to_time + segundos.seconds),
						:className => 'evento-activo',
						:backgroundColor => fondo,
						:borderColor => fondo,
						:textColor => texto
						}
				segundos = segundos + 1
				producciones = {:id => segundos, :title => 'Produccion por turno', 
					:url => crear_produccion_path(dia),
					:start => (dia.to_time + segundos.seconds),
					:className => 'evento-activo',
					:backgroundColor => fondo,
					:borderColor => fondo,
					:textColor => texto
					}
				respuesta << insumos
				respuesta << producciones
			end
			
			respond_to do |format|
				format.json { render json: respuesta }
			end
		end
	end
	
end
