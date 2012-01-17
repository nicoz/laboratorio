class EscritorioController < ApplicationController
  def show
  	add_breadcrumb 'Escritorio', escritorio_path
  	@title = "Escritorio"
  	#@search = Actividad.search(params[:search])
  	#@actividades = @search.paginate(:page => params[:page], :per_page => 10,:limit => 100, :order => 'created_at DESC')
  	
  	@actividades = Actividad.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  	@ultimosUsuarios = Usuario.find(:all, :order => "created_at desc", :limit => 5)
  end

end
