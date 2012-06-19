class DiaController < ApplicationController
  before_filter :autenticar,     :only => [:show, :dias]
  before_filter :validar_turno_dia,	:only => [:show]

  add_breadcrumb 'Escritorio', '/escritorio'

  def show
    if params[:fecha].nil?
      flash[:error] = "Debe ingresar una fecha correcta"
      redirect_to escritorio_path
    else
      fecha = Date.parse(params[:fecha])
      @dia = Dia.find_or_create_by_fecha(fecha)

      @zafra = Zafra.where('dia_inicio <= ? and (dia_fin >= ? or dia_fin is null)', @dia.fecha, @dia.fecha).first
      @turnos = Turno.find(:all, :conditions => {:habilitado => true}, :order => 'orden')
      @turnos_dia = []
      @turnos.each do |turno|
        td = TurnoDia.find_by_dia_id_and_turno_id(@dia, turno)

        if td.nil?
          td = @dia.turnos.build(:estado => "Abierto")
          td.turno = turno
        end
        @turnos_dia << td
      end
    end

    add_breadcrumb "#{l @dia.fecha}", @dia
  end

  def edit
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_or_create_by_fecha(fecha)
    @title = "Editar Dia"
    add_breadcrumb 'Dias', ver_dia_path(@dia.fecha)
    add_breadcrumb "#{l @dia.fecha}", editar_dia_path(@dia.fecha)
  end

  def update
    @dia = Dia.find(params[:id])
    flash[:success] = "Dia modificado"
    if @dia.update_attributes(params[:dia])
      flash[:success] = "Dia modificado"
      redirect_to ver_dia_path(@dia.fecha)
    else
      @title = "Editar Dia"
      render 'edit'
    end
  end

  def analisis_turno
    if params[:fecha].nil?
      flash[:error] = "Debe ingresar una fecha correcta"
      redirect_to escritorio_path
    else
      fecha = Date.parse(params[:fecha])
      @dia = Dia.find_or_create_by_fecha(fecha)

      @turnos = Turno.find(:all, :conditions => {:habilitado => true}, :order => 'orden')
      @turnos_dia = []
      @turnos.each do |turno|
        td = TurnoDia.find_by_dia_id_and_turno_id(@dia, turno)

        if td.nil?
          td = @dia.turnos.build(:estado => "Abierto")
          td.turno = turno
        end
        @turnos_dia << td
      end
    end

    add_breadcrumb "#{l @dia.fecha}", @dia
  end

  def dias
    if !params[:fecha].nil?
      fecha = Date.parse(params[:fecha])
      inicio = (fecha.to_time - 45.days).to_date
      fin = Time.now.to_date

      zafras = Zafra.where('dia_inicio >= ? and dia_inicio <= ?', inicio, Time.now.to_date)

      respuesta = []
      inicio.upto(fin) do |dia|
        segundos = 0
        segundos = segundos + 1
        fondo = '#006600' if dia < Time.now.to_date
        fondo = '#330099' if dia == Time.now.to_date

        zafras.each do |zafra|
          if !zafra.dia_fin.nil?
            fondo = '#B80000' if dia >= zafra.dia_inicio and dia <= zafra.dia_fin
          else
            fondo = '#FF9933' if dia >= zafra.dia_inicio and dia <= Time.now.to_date
          end
        end

        fondo = '#FFFFFF' if dia > Time.now.to_date
        texto = 'white'
        texto = '#888888' if dia > Time.now.to_date
        borde = fondo
        borde = texto if dia > Time.now.to_date
        insumosDiarios = {:id => segundos, :title => 'Insumos Diarios',
            :url => crear_insumo_diario_path(dia),
            :start => (dia.to_time + segundos.seconds),
            :className => 'evento-activo',
            :backgroundColor => fondo,
            :borderColor => borde,
            :textColor => texto
            }
        segundos = segundos + 1
        produccionMasa = {:id => segundos, :title => 'Produccion Masa',
            :url => crear_produccion_masa_path(dia),
            :start => (dia.to_time + segundos.seconds),
            :className => 'evento-activo',
            :backgroundColor => fondo,
            :borderColor => borde,
            :textColor => texto
            }
        segundos = segundos + 1
        insumos = {:id => segundos, :title => 'Insumos por turno',
            :url => crear_insumo_path(dia),
            :start => (dia.to_time + segundos.seconds),
            :className => 'evento-activo',
            :backgroundColor => fondo,
            :borderColor => borde,
            :textColor => texto
            }
        segundos = segundos + 1
        producciones = {:id => segundos, :title => 'Produccion por turno',
          :url => crear_produccion_path(dia),
          :start => (dia.to_time + segundos.seconds),
          :className => 'evento-activo',
          :backgroundColor => fondo,
          :borderColor => borde,
          :textColor => texto
          }
        segundos = segundos + 1
        recepcion = {:id => segundos, :title => 'Recepcion',
          :url => crear_recepcion_path(dia),
          :start => (dia.to_time + segundos.seconds),
          :className => 'evento-activo',
          :backgroundColor => fondo,
          :borderColor => borde,
          :textColor => texto
          }
          #ver_analisis_turno
        segundos = segundos + 1
        analisis = {:id => segundos, :title => 'Analisis por turno',
          :url => ver_analisis_turno_path(dia),
          :start => (dia.to_time + segundos.seconds),
          :className => 'evento-activo',
          :backgroundColor => fondo,
          :borderColor => borde,
          :textColor => texto
          }
        segundos = segundos + 1
        dias = {:id => segundos, :title => 'Ver dia',
          :url => ver_dia_path(dia),
          :start => (dia.to_time + segundos.seconds),
          :className => 'evento-activo',
          :backgroundColor => fondo,
          :borderColor => borde,
          :textColor => texto
          }
        respuesta << insumosDiarios
        #respuesta << produccionMasa
        #respuesta << insumos
        respuesta << producciones
        #respuesta << recepcion
        respuesta << analisis
        respuesta << dias
      end

      respond_to do |format|
        format.json { render json: respuesta }
      end
    end
  end

end
