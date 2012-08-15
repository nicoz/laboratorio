class AnalisesController < ApplicationController
  before_filter :autenticar,     :only => [:index, :edit, :update, :destroy, :create, :new, :show]
  before_filter :validar_turno_dia,  :only => [:new, :edit]
  before_filter :zafra_abierta, :only => [:new, :edit]
  before_filter :solo_reportes

  add_breadcrumb 'Escritorio', '/escritorio'

  def index
    add_breadcrumb 'Analisis', turnos_path
    @title = "Analisis"
    @search = Analisis.search(params[:search])
    @analisis = @search.paginate(:page => params[:page], :per_page => 10, :order => 'created_at')
    @busqueda = params[:search]
  end

  def show
    @analisis = Analisis.find(params[:id])
    @title = "#{@analisis.turno_dia.turno.nombre} #{l @analisis.turno_dia.dia.fecha}"
    add_breadcrumb 'Analisis', turnos_path
    add_breadcrumb @analisis.turno_dia.turno.nombre, @analisis
  end

  def new
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)
    if @dia.nil?
      @dia = Dia.new(:fecha => fecha)
    end

    add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

    @turno = Turno.find(params[:id])

    @turnoDia = TurnoDia.find_or_create_by_dia_id_and_turno_id(@dia.id, @turno.id)

    if @turnoDia.analisis.nil?
      @analisis = Analisis.new
      @analisis.turnoDia = @turnoDia
      @title = "Crear Analisis"
      add_breadcrumb 'Crear Analisis', analises_path
    else
      @analisis = @turnoDia.analisis
      add_breadcrumb 'Editar Analisis', analises_path
      @title = "Editar Analisis"
      render 'edit'
    end
  end

  def create
    @title = 'Crear Analisis'
    @analisis = Analisis.new(params[:analisis])
    if @analisis.save
      flash[:success] = "Analisis correctamente creado"
      redirect_to ver_dia_path(@analisis.turnoDia.dia.fecha)
    else
      @title = "Crear Analisis"
      render 'new'
    end
  end



  def update
    @analisis = Analisis.find(params[:id])
    @turnoDia = @analisis.turnoDia
    @dia = @analisis.turnoDia.dia
    if @analisis.update_attributes(params[:analisis])
      flash[:success] = "Analisis modificado"
      redirect_to ver_dia_path(@analisis.turnoDia.dia.fecha)
    else
      @title = "Editar Analisis"
      render 'new'
    end
  end

  def destroy
    #se destruyen?
  end

  def validar
    turnoDia = TurnoDia.find(params[:turno])
    analisis = turnoDia.analisis

    analisis = Analisis.new if analisis.nil?

    analisis[params[:nombre]] = params[:valor]
    analisis.turnoDia = turnoDia

    if analisis.valid?
      mensaje = "OK"
    else
      mensaje = analisis.errors[params[:nombre]]
    end

    render :json => {:mensaje => mensaje}
  end

end
