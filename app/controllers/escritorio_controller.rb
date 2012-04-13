class EscritorioController < ApplicationController
  def show
  	add_breadcrumb 'Escritorio', escritorio_path
  	@title = "Escritorio"
  	if !usuario_actual.nil?
		if usuario_actual.admin?
			@actividades = Actividad.find(:all, :order => "created_at desc", :limit => 5)
			@ultimosUsuarios = Usuario.find(:all, :order => "created_at desc", :limit => 5)
		end
	
		if !usuario_actual.admin?
			mes = Date.today.month
			@date = Date.today
			if !params[:mes].nil?
				mes = params[:mes]
			end
			@dias = Dia.all
			#where("fecha.month = mes")
		end
	else
		redirect_to ingresar_path(usuario_actual)
	end
  end

end
