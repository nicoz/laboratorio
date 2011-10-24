class PaginasController < ApplicationController
  def inicio
  	@title = "Inicio"
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
