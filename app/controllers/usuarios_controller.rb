class UsuariosController < ApplicationController
  	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
  	before_filter :usuario_correcto, 	:only => [:edit, :update]
  	before_filter :usuario_admin, 		:only => [:index, :new, :create, :destroy]	
  	
  	
  	def index
  		@title = "Listado de Usuarios"
		@search = Usuario.search(params[:search])
  		@usuarios = @search.paginate(:page => params[:page])
		@busqueda = params[:search]
  	end
  	
	def new
		@title = "Crear Usuario"
		@usuario = Usuario.new
	end

	def show
		@usuario = Usuario.find(params[:id])
		@title = @usuario.nombre
	end
	
	def create
		@usuario = Usuario.new(params[:usuario])
		if @usuario.save
			#aca ya guarde en la bd
			flash[:success] = "Usuario correctamente creado"
			redirect_to @usuario
		else
			@title = "Crear Usuario"
			render 'new'
		end
	end
	
	def edit
		@usuario = Usuario.find(params[:id])
		@title = "Editar Usuario"
	end
	
	def update 
		@usuario = Usuario.find(params[:id])

		if @usuario.update_attributes(params[:usuario])
			flash[:success] = "Usuario modificado"
			redirect_to @usuario		
		else
			@title = "Editar Usuario"
			render 'edit'
		end
	end
	
	def destroy
		usuario = Usuario.find(params[:id])
		if usuario == usuario_actual 
			flash[:error] = "No se puede eliminar a si mismo."
		else
			Usuario.find(params[:id]).destroy
			flash[:success] = "Usuario destruido."
		end 
		redirect_to usuarios_path
	end
	
	private
		def autenticar
			negar_acceso unless ingresado?
		end
		
		def usuario_correcto
			@usuario = Usuario.find(params[:id])
			redirect_to(root_path) unless usuario_actual?(@usuario) || usuario_actual.admin?
		end
		
		def usuario_admin
			redirect_to(root_path) unless usuario_actual.admin?
		end
end
