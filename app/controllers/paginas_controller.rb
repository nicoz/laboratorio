class PaginasController < ApplicationController
  def inicio
	if usuario_actual.nil?
		redirect_back_or ingresar_path(usuario_actual)
	else
		redirect_back_or escritorio_path(usuario_actual)
	end
  end

  def contacto
  	@title = "Contacto"
  end

  def acerca
  	@title = "Acerca de"
  end
  
  def ayuda
  	@title = "Ayuda"
  end

end
