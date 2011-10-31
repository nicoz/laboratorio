class UsuariosController < ApplicationController
  
  
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
end
