class ProduccionsController < ApplicationController
	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	add_breadcrumb 'Escritorio', '/escritorio'
	
	def index
		add_breadcrumb 'Producciones', turnos_path
		@title = "Producciones"
		@search = Produccion.search(params[:search])
		@producciones = @search.paginate(:page => params[:page], :per_page => 10, :order => 'created_at')
		@busqueda = params[:search]
	end
	
	def show
		@produccion = Produccion.find(params[:id])
		@title = "#{@produccion.turno_dia.turno.nombre} #{l @produccion.turno_dia.dia.fecha}"
		add_breadcrumb 'Producciones', turnos_path
		add_breadcrumb @produccion.turno_dia.turno.nombre, @produccion
	end
	
	def new
		turno = TurnoDia.find(params[:turno])
		add_breadcrumb "#{turno.turno.nombre} #{l turno.dia.fecha}", ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		
		
		@produccion = Produccion.find_by_turnoDia_id(turno)
		if @produccion.nil?
			add_breadcrumb 'Crear Produccion', insumos_path
			@produccion = Produccion.new
			@produccion.turnoDia = turno
			@title = "Crear Produccion"
		else
			add_breadcrumb 'Editar Produccion', produccions_path
			@title = "Editar Produccion"
			render 'edit'
		end
	end
	
	def create
		@produccion = Produccion.new(params[:produccion])
		turno = TurnoDia.find(params[:produccion][:turnoDia_id])
		@produccion.turnoDia = turno
		if @produccion.save
			flash[:success] = "Produccion correctamente creada"
			redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		else
			@title = "Crear Produccion"
			render 'new'
		end
	end
	
	def edit
		turno = TurnoDia.find(params[:turno])
		add_breadcrumb "#{turno.turno.nombre} #{l turno.dia.fecha}", ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		@produccion = Produccion.find_by_turnoDia_id(params[:turno])
		@title = "Editar Produccion"
		add_breadcrumb 'Editar Produccion', producciones_path
	end
	
	def update
		@produccion = Produccion.find(params[:id])
		turno = TurnoDia.find(params[:produccion][:turnoDia_id])
		if @produccion.update_attributes(params[:produccion])
			flash[:success] = "Produccion modificada"
			redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		else
			@title = "Editar Produccion"
			render 'edit'
		end
	end
	
	def destroy
		#se destruyen?
	end
	
	private
		def validar_turno_dia
			turno = TurnoDia.find(params[:turno])
			if turno.estado != 'Abierto'
				flash[:error] = 'No se pueden crear/editar datos de la produccion si el turno no esta Abierto.'
				redirect_to escritorio_path
			end
		end
end
