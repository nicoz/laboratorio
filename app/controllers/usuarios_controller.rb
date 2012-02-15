class UsuariosController < ApplicationController
  	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
  	before_filter :usuario_correcto, 	:only => [:edit, :update]
  	before_filter :permitir_modificar_clave,:only => [:edit_password]
  	before_filter :usuario_admin, 		:only => [:index, :new, :create, :destroy]
  	add_breadcrumb 'Escritorio', '/escritorio'
  	
  	def index
  		add_breadcrumb 'Usuarios', usuarios_path
  		@title = "Usuarios"
		@search = Usuario.search(params[:search])
  		@usuarios = @search.paginate(:page => params[:page], :per_page => 10)
		@busqueda = params[:search]
  	end
  	
	def new
		add_breadcrumb 'Usuarios', usuarios_path
		add_breadcrumb 'Crear Usuario', usuarios_path
		@title = "Crear Usuario"
		@usuario = Usuario.new
	end

	def show
		add_breadcrumb 'Usuarios', usuarios_path
		@usuario = Usuario.find(params[:id])
		@title = @usuario.nombre
		add_breadcrumb @usuario.nombre, @usuario
	end
	
	def create
		@usuario = Usuario.new(params[:usuario])
		if @usuario.save
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
		add_breadcrumb 'Usuarios', usuarios_path
		add_breadcrumb @usuario.nombre, edit_usuario_path(@usuario)
	end
	
	def edit_password
		@usuario = Usuario.find(params[:id])
		@title = "Modificar Clave"
		add_breadcrumb 'Usuarios', usuarios_path
		add_breadcrumb @usuario.nombre, edit_usuario_path(@usuario)
	end
	
	def reset_password
		@usuario = Usuario.find(params[:id])
		if (@usuario.update_attributes({:password => "azucarlito", :passoword_confirmation => "azucarlito", :modo => 3}))
			flash[:success] = 'Clave reseteada'
			redirect_to usuarios_path
		else
			flash[:error] = 'Ocurrio un problema reseteando la clave'
			redirect_to usuarios_path
		end
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
			if Usuario.find(params[:id]).destroy
				flash[:success] = "Usuario destruido."
			else
				flash[:error] = "No se permite eliminar usuarios que hayan tenido actividad en el sistema. Deshabilitelo."
			end
		end 
		redirect_to usuarios_path
	end
	
	private

		
		def permitir_modificar_clave
			usuario = Usuario.find(params[:id])
			unless usuario_actual?(usuario)
				flash[:error] = "No puede modificar la clave de otros usuarios"
				redirect_to(escritorio_path) 
			end
		end
		

end
