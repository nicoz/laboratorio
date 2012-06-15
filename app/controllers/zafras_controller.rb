class ZafrasController < ApplicationController
  before_filter :autenticar

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
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
end
