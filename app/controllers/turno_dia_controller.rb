class TurnoDiaController < ApplicationController
  add_breadcrumb 'Escritorio', '/escritorio'
  before_filter :solo_reportes

  def index
  end

  def show
    fecha = Date.parse(params[:fecha])
    turno = Turno.find_by_nombre(params[:nombre])
    @dia = Dia.find_or_create_by_fecha(fecha)
    @turno_dia = TurnoDia.find_by_dia_id_and_turno_id(@dia, turno)
    if @turno_dia.nil?
      @turno_dia = @dia.turnos.build(:estado => "Abierto")
      @turno_dia.turno = turno
      if @turno_dia.save
        add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha)
        add_breadcrumb "#{@turno_dia.turno.nombre}", @turno_dia.turno.nombre
      else
        flash[:error] = "Ha ocurrido un error creando el Turno \"#{params[:nombre]}\" para el dia #{l fecha}"
        redirect_to escritorio_path
      end
    else
      @insumo = Insumo.find_by_turnoDia_id(@turno_dia)
      @produccion = Produccion.find_by_turnoDia_id(@turno_dia)
      add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha)
      add_breadcrumb "#{@turno_dia.turno.nombre}", @turno_dia.turno.nombre
    end

  end

  def cerrar
    turno = TurnoDia.find(params[:id])
    validacion = validar_contenido(turno)
    validado = validacion[:resultado]
    mensaje = validacion[:mensaje]
    if validado
      if turno.estado == "Abierto"
        turno.estado = "Cerrado"

        if turno.save()
          flash[:success] = "Turno del dia correctamente cerrado"
        else
          flash[:error] = "Ocurrio un error cuando se cerraba el turno."
        end
      else
        flash[:error] = "No se puede cerrar un turno que no este abierto"
      end
    else
      flash[:error] = mensaje
    end
    redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
  end

  def anular
    turno = TurnoDia.find(params[:id])
    if turno.estado == "Abierto"
      turno.estado = "Anulado"
      if turno.save()
        flash[:success] = "Turno del dia correctamente anulado"
      else
        flash[:error] = "Ocurrio un error cuando se anulaba el turno."
      end
    else
      flash[:error] = "No se puede anular un turno que no este abierto"
    end
    redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
  end

  def abrir
    turno = TurnoDia.find(params[:id])
    if turno.estado == "Cerrado" or turno.estado == "Anulado"
      turno.estado = "Abierto"
      if turno.save()
        flash[:success] = "Turno del dia correctamente abierto"
      else
        flash[:error] = "Ocurrio un error cuando se abria el turno."
      end
    else
      flash[:error] = "No se puede abrir un turno que no este cerrado o anulado"
    end
    redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
  end

  private

    def validar_contenido(turno)

      validado = true
      mensaje = ""

      insumo = Insumo.find_by_turnoDia_id(turno)
      if insumo.nil? and validado
        mensaje = "Aun no se ingresaron datos de los Insumos"
        validado = false
      end

      if !insumo.nil? and !insumo.valid? and validado
        mensaje = "Existen incongruencias en los datos de los Insumos"
        validado = false
      end

      produccion = Produccion.find_by_turnoDia_id(turno)
      if produccion.nil? and validado
        mensaje = "Aun no se ingresaron datos de la Produccion"
        validado = false
      end

      if !produccion.nil? and !produccion.valid? and validado
        mensaje = "Existen incongruencias en los datos de la Produccion"
        validado = false
      end
      resultado = {:resultado => validado, :mensaje => mensaje}
      return resultado
    end
end
