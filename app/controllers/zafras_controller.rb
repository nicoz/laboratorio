class ZafrasController < ApplicationController
  before_filter :autenticar

  add_breadcrumb 'Escritorio', '/escritorio'

  def index
    add_breadcrumb 'Zafras', zafras_path
    @title = "Zafras"

    @search = Zafra.search(params[:search])
    @search.meta_sort = 'dia_inicio'
    @zafras = @search.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    add_breadcrumb 'Zafras', zafras_path
    add_breadcrumb 'Crear Zafra', zafras_path
    @title = "Crear Zafra"
    @zafra = Zafra.new
  end

  def show
    add_breadcrumb 'Zafras', zafras_path
    @zafra = Zafra.find(params[:id])
    @title = @zafra.dia_inicio
    add_breadcrumb @zafra.dia_inicio, @zafra
  end

  def create
    @zafra = Zafra.new(params[:zafra])
    if @zafra.save
      flash[:success] = "Zafra correctamente creada"
      redirect_to @zafra
    else
      @title = "Crear Zafra"
      render 'new'
    end
  end

  def edit
    @zafra = Zafra.find(params[:id])
    @title = "Editar Zafra"
    add_breadcrumb 'Zafras', zafras_path
    add_breadcrumb @zafra.dia_inicio, edit_zafra_path(@zafra)
  end

  def update
    @zafra = Zafra.find(params[:id])
    if @zafra.update_attributes(params[:zafra])
      flash[:success] = "Zafra modificada"
      redirect_to @zafra
    else
      @title = "Editar Zafra"
      render 'edit'
    end
  end

  def destroy
    zafra = Zafra.find(params[:id])
    if zafra.destroy
      flash[:success] = "Zafra destruida."
    else
      flash[:error] = "No se pudo eliminar la Zafra"
    end
    redirect_to zafras_path
  end

  def new_ajax
    dia = Dia.find_by_fecha(params[:fecha])

    zafra = Zafra.new
    zafra.dia_inicio = dia.fecha
    mensaje = 'OK'
    if !zafra.save()
      mensaje = zafra.errors[:dia_inicio]
    end

    resultado = {:mensaje => mensaje}
    render :json => resultado
  end

  def update_ajax
    dia = Dia.find_by_fecha(params[:fecha])

    zafra = Zafra.find_by_dia_inicio(params[:fecha_fin])
    zafra.dia_fin = dia.fecha
    mensaje = 'OK'
    if !zafra.save()
      mensaje = zafra.errors[:dia_fin]
    end

    resultado = {:mensaje => mensaje}
    render :json => resultado
  end

  def validar
    zafra = Zafra.find(params[:zafra]) if params[:zafra] != '0'
    zafra = Zafra.new if zafra.nil?

    zafra[params[:nombre]] = params[:valor]

    if zafra.valid?
      mensaje = "OK"
    else
      mensaje = zafra.errors[params[:nombre]]
    end

    render :json => {:mensaje => mensaje}
  end
end
