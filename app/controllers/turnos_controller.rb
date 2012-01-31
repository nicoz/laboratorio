class TurnosController < ApplicationController
	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	before_filter :usuario_admin, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	add_breadcrumb 'Escritorio', '/escritorio'
	
	def index
		add_breadcrumb 'Turnos', turnos_path
		@title = "Turnos"
		@search = Turno.search(params[:search])
		@turnos = @search.paginate(:page => params[:page], :per_page => 10, :order => 'orden')
		@busqueda = params[:search]
	end
	
	def show
		@turno = Turno.find(params[:id])
		@title = @turno.nombre
		add_breadcrumb 'Turnos', turnos_path
		add_breadcrumb @turno.nombre, @turno
	end
	
	def new
		add_breadcrumb 'Turnos', usuarios_path
		add_breadcrumb 'Crear Turno', usuarios_path
		@title = "Crear Turno"
		@turno = Turno.new
	end
	
	def create
		@turno = Turno.new(params[:turno])
		if @turno.save
			flash[:success] = "Turno correctamente creado"
			redirect_to @turno
		else
			@title = "Crear Turno"
			render 'new'
		end
	end
	
	def edit
		@turno = Turno.find(params[:id])
		@title = "Editar Turno"
		add_breadcrumb 'Turnos', turnos_path
		add_breadcrumb @turno.nombre, edit_turno_path(@turno)
	end
	
	def update
		@turno = Turno.find(params[:id])
		if @turno.update_attributes(params[:turno])
			flash[:success] = "Turno modificado"
			redirect_to @turno
		else
			@title = "Editar Turno"
			render 'edit'
		end
	end
	
	def destroy
		if Turno.find(params[:id]).destroy
			flash[:success] = "Turno destruido."
		else
			flash[:error] = "No se pudo eliminar el turno"
		end
		redirect_to turnos_path
	end
end
