class UsuariosController < ApplicationController
  
  
	def new
		@title = "Crear Usuario"
	end

	def show
		@usuario = Usuario.find(params[:id])
	end
end
