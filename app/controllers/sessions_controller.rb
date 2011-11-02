class SessionsController < ApplicationController
  
  def new
  	@title = "Ingreso"
  end
  
  def create
  	usuario = Usuario.authenticate(params[:session][:email],
  				       params[:session][:password])
  				       
  	if usuario.nil?
  		flash.now[:error] = "Combinacion Email/Clave invalida"	
		@title = "Ingreso"
  		render 'new'
  	else
  		ingresar usuario
  		redirect_to escritorio_path(usuario)
  	end
  end
  
  def destroy
  	salir
  	redirect_to root_path
  end

end
