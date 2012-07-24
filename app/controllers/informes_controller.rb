class InformesController < ApplicationController
  before_filter :autenticar

  def produccion_turno

    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    @title = "Produccion por turno #{l @dia.fecha}"

    tieneDatos = false
    @dia.turnos.each do |turno|
        tieneDatos = true if !turno.produccion.nil?
    end

    if tieneDatos
      @dia.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }

      @totales = {:paquetesPapel => 0, :paquetesPolietileno => 0, :melaza => 0,
        :rubio => 0, :industriaBolsas => 0, :bolsasAzucarlito => 0, :bigBagAzucarlito => 0,
        :bigBagDnd => 0
      }

      @clientes = []
      @granTotal = {:totales => 0}

      turno1 = @dia.turnos.first
      turno1.produccion.clientes.each do |cliente|
        @totales[cliente.cliente.nombre] = 0
        @clientes << cliente.cliente.nombre

      end
      @turnos = @dia.turnos.sort_by {|obj| obj.turno.orden}


      @turnos.each do |turno|
        @granTotal[turno.turno.nombre] = 0

        @totales[:paquetesPapel] += turno.produccion.paquetesPapel
        @totales[:paquetesPolietileno] += turno.produccion.paquetesPolietileno
        @totales[:melaza] += turno.produccion.melaza
        @totales[:rubio] += turno.produccion.rubio
        @totales[:industriaBolsas] += turno.produccion.industriaBolsas
        @totales[:bolsasAzucarlito] += turno.produccion.bolsasAzucarlito
        @totales[:bigBagAzucarlito] += turno.produccion.bigBagAzucarlito
        @totales[:bigBagDnd] += turno.produccion.bigBagDnd

        @granTotal[turno.turno.nombre] = turno.produccion.paquetesPapel +
          turno.produccion.paquetesPolietileno +
          turno.produccion.industriaBolsas + turno.produccion.bolsasAzucarlito +
          turno.produccion.bigBagAzucarlito + turno.produccion.bigBagDnd

        turno.produccion.clientes.each do |cliente|
          @totales[cliente.cliente.nombre] += cliente.azucar_big_bag
          @granTotal[turno.turno.nombre] += cliente.azucar_big_bag
          @granTotal[:totales] += cliente.azucar_big_bag
        end


      end

      @granTotal[:totales] += @totales[:paquetesPapel] + @totales[:paquetesPolietileno] +
        @totales[:industriaBolsas] + @totales[:bolsasAzucarlito] +
        @totales[:bigBagAzucarlito] + @totales[:bigBagDnd]

      render :layout => 'informes'
    else
      redirect_to ver_dia_path(@dia.fecha)
    end
  end

  def produccion_masas_cocidas
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    @title = "Produccion Masas Cocidas #{l @dia.fecha}"

    render :layout => 'informes'
  end

  def recepcion
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    @title = "Recepcion de crudo y balance #{l @dia.fecha}"
    render :layout => 'informes'
  end

  def insumos_diarios
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    @title = "Insumos Diarios #{l @dia.fecha}"
    render :layout => 'informes'
  end

  def insumos_por_turno
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    @title = "Insumos por turno #{l @dia.fecha}"

    @totales = { :crudoProcesado => 0, :tiraje => 0}

    @dia.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }

    @dia.turnos.each do |turno|
      @totales[:crudoProcesado] += turno.insumo.crudoProcesado
      @totales[:tiraje] += turno.insumo.tiraje
    end

    render :layout => 'informes'
  end

  def analisis_promedio
    @dia = Dia.find_by_fecha(Date.parse(params[:fecha]))
    @dia.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }

    @title = "Promedio de Analisis #{l @dia.fecha}"
    analisis_id_inicial = 0

    #arranco los resultados con el primer dia cargado
    @dia.turnos.each do |turno|
      analisis_id_inicial = turno.analisis.id if @promedio.nil? and !turno.analisis.nil?
      @promedio = turno.analisis.attributes if @promedio.nil? and !turno.analisis.nil?
    end


    #saco los elementos del hash que no me sirven
    if !@promedio.nil?
      @promedio.delete("id")
      @promedio.delete("updated_at")
      @promedio.delete("created_at")
      @promedio.delete("turnoDia_id")

      @promedio.each do |key, value|
        cantidadTurnos = 1
        @dia.turnos.each do |turno|
          analisis = turno.analisis
          if !analisis.nil?
            if analisis.id != analisis_id_inicial
              value = analisis[key] if value.nil?
              value += analisis[key] if !value.nil? and !analisis[key].nil?
              cantidadTurnos += 1 if !analisis[key].nil?
            end
          end
        end

        @promedio[key] = value / cantidadTurnos if cantidadTurnos > 0 and !value.nil?
      end
    end

    render :layout => 'informes'
  end

  def analisis_promedio_zafra
    @dia = Dia.find_by_fecha(Date.parse(params[:fecha]))

    @zafra = Zafra.where('dia_inicio <= ? and (dia_fin >= ? or dia_fin is null)', @dia.fecha, @dia.fecha).first

    @title = "Promedio de Analisis de la zafra #{l @zafra.dia_inicio}"

    analisis_id_inicial = 0
    fin = @zafra.dia_fin
    fin = Date.current if fin.nil?

    @dias = Dia.where('fecha >= ? and fecha <= ?', @zafra.dia_inicio, fin)

    #recorro cada dia de la zafra
    @dias.each do |d|
      d.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }

      #busco el primer valor cargado de analisis
      d.turnos.each do |turno|
        analisis_id_inicial = turno.analisis.id if @promedio.nil? and !turno.analisis.nil?
        @promedio = turno.analisis.attributes if @promedio.nil? and !turno.analisis.nil?
      end

      if !@promedio.nil?
        #saco los elementos del hash que no me sirven
        @promedio.delete("id")
        @promedio.delete("updated_at")
        @promedio.delete("created_at")
        @promedio.delete("turnoDia_id")

        @promedio.each do |key, value|
          cantidadTurnos = 1
          d.turnos.each do |turno|
            analisis = turno.analisis
            if !analisis.nil?
              if analisis.id != analisis_id_inicial
                value = analisis[key] if value.nil?
                value += analisis[key] if !value.nil? and !analisis[key].nil?
                cantidadTurnos += 1 if !analisis[key].nil?
              end
            end
          end

          @promedio[key] = value / cantidadTurnos if cantidadTurnos > 0 and !value.nil?
        end
      end
    end

    if !@promedio.nil?
      render :layout => 'informes'
    else
      flash[:warning] = 'No existen datos de analisis ingresados para toda la zafra'
      redirect_to ver_dia_path(@dia.fecha)
    end
  end
end
