class EscritorioController < ApplicationController
  def show
  	add_breadcrumb 'Escritorio', escritorio_path
  	@title = "Escritorio"
	if usuario_actual.admin?
		@actividades = Actividad.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
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
  end

end
