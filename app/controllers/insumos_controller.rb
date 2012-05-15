class InsumosController < ApplicationController
	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	add_breadcrumb 'Escritorio', '/escritorio'
	
	def index
		add_breadcrumb 'Insumos', turnos_path
		@title = "Insumos"
		@search = Insumo.search(params[:search])
		@insumos = @search.paginate(:page => params[:page], :per_page => 10, :order => 'created_at')
		@busqueda = params[:search]
	end
	
	def show
		@insumo = Insumo.find(params[:id])
		@title = "#{@insumo.turno_dia.turno.nombre} #{l @insumo.turno_dia.dia.fecha}"
		add_breadcrumb 'Insumos', turnos_path
		add_breadcrumb @insumo.turno_dia.turno.nombre, @insumo
	end
	
	def new
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_by_fecha(fecha)
		if @dia.nil?
			@dia = Dia.new(:fecha => fecha)
		end
		
		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)
		
		turnos = Turno.find(:all, :order => 'orden', :conditions => ["habilitado =?", true])
		
		#creo los turnos para el dia
		if @dia.turnos.empty?
			turnos.each do |turno|
				td = TurnoDia.new
				td.turno = turno
				td.dia = @dia
				#creo un insumo para cada turno
				insumo = Insumo.new
				insumo.turnoDia = td
				td.insumo = insumo
				@dia.turnos << td
			end
			@title = "Crear Insumos"
			add_breadcrumb 'Crear Insumos', insumos_path
		else
			@dia.turnos.each do |turno|
				if turno.insumo.nil?
					insumo = Insumo.new
					insumo.turnoDia = turno
					turno.insumo = insumo
				end
			end
			add_breadcrumb 'Editar Insumos', insumos_path
			@title = "Editar Insumos"
			render 'edit'
		end
	end
	
	def create
		@title = 'Crear Insumos'
		@dia = Dia.find_or_create_by_fecha(params[:dia][:fecha])
		valido = true
		turnos = Turno.find(:all, :conditions => ["habilitado =?", true])
		turnos.each do |turno|
			turnoDia = TurnoDia.find_or_create_by_dia_id_and_turno_id(@dia, turno.id)
			turnoDia.turno = turno
			insumo = Insumo.find_or_create_by_turnoDia_id(turnoDia.id)
			insumo.crudoProcesado = params[:turno][turno.id.to_s][:crudoProcesado]
			insumo.tiraje = params[:turno][turno.id.to_s][:tiraje]
			insumo.turnoDia = turnoDia
			
			if insumo.save
				turnoDia.insumo = insumo
				@dia.turnos << turnoDia
			else
			        valido = false
				
				turnoDia.insumo = insumo
				@dia.turnos << turnoDia
				
			end
		end
		
		if valido
		        flash[:success] = 'Insumos guardados'
		        redirect_to ver_dia_path(@dia.fecha)
		else
		        flash[:error] = 'Errores al guardar el insumo'
		        render 'new'
		end
	end
	
	def edit
		turno = TurnoDia.find(params[:turno])
		add_breadcrumb "#{turno.turno.nombre} #{l turno.dia.fecha}", ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		@insumo = Insumo.find_by_turnoDia_id(params[:turno])
		@title = "Editar Insumo"
		add_breadcrumb 'Editar Insumo', insumos_path
	end
	
	def update
		@insumo = Insumo.find(params[:id])
		turno = TurnoDia.find(params[:insumo][:turnoDia_id])
		if @insumo.update_attributes(params[:insumo])
			flash[:success] = "Insumo modificado"
			redirect_to ver_dia_path(insumo.turnoDia.dia.fecha)
		else
			@title = "Editar Insumo"
			render 'edit'
		end
	end
	
	def destroy
		#se destruyen?
	end
	
	def validar
		insumo = Insumo.find(params[:insumo]) unless params[:insumo] == '0'
		insumo = Insumo.new if insumo.nil?
		
		insumo[params[:nombre]] = params[:valor]
		insumo.turnoDia_id = params[:turno]
		if insumo.valid?
			mensaje = "OK"
		else
			mensaje = insumo.errors[params[:nombre]]
		end
		
		render :json => {:mensaje => mensaje}
	end
	
end
