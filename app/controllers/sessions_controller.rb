class SessionsController < ApplicationController
  
  def new
  	if usuario_actual.nil?
  		@title = "Ingreso"
  		flash[:notice] = "Debe ingresar su usuario y clave antes de continuar"
  	else
  		redirect_back_or escritorio_path
	end
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
  		redirect_back_or escritorio_path
  	end
  end
  
  def destroy
  	salir
  	redirect_to root_path
  end

	def nuevo
	
	end
end
