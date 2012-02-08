class InsumosController < ApplicationController
	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
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
		add_breadcrumb 'Insimos', turnos_path
		add_breadcrumb @insumo.turno_dia.turno.nombre, @insumo
	end
	
	def new
		turno = TurnoDia.find(params[:turno])
		add_breadcrumb "#{turno.turno.nombre} #{l turno.dia.fecha}", ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		
		
		@insumo = Insumo.find_by_turnoDia_id(turno)
		if @insumo.nil?
			add_breadcrumb 'Crear Insumo', insumos_path
			@insumo = Insumo.new
			@insumo.turnoDia = turno
			@title = "Crear Insumo"
		else
			add_breadcrumb 'Editar Insumo', insumos_path
			@title = "Editar Insumo"
			render 'edit'
		end
	end
	
	def create
		@insumo = Insumo.new(params[:insumo])
		turno = TurnoDia.find(params[:insumo][:turnoDia_id])
		@insumo.turnoDia = turno
		if @insumo.save
			flash[:success] = "Insumo correctamente creado"
			redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		else
			@title = "Crear Insumo"
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
			redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		else
			@title = "Editar Insumo"
			render 'edit'
		end
	end
	
	def destroy
		#se destruyen?
	end
end
