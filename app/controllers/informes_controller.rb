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
      @turnos = @dia.turnos.sort_by {|obj| obj.turno.orden}

      @clientes = []
      @granTotal = {:totales => 0}
      turno1 = nil

      @dia.turnos.each do |turno|
        turno1 = turno if !turno.produccion.nil? and turno1.nil?
      end

      if !turno1.produccion.nil?
        turno1.produccion.clientes.each do |cliente|
          @totales[cliente.cliente.nombre] = 0
          @clientes << cliente.cliente.nombre

        end
      end



      @turnos.each do |turno|
        @granTotal[turno.turno.nombre] = 0

        if !turno.produccion.nil?
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
            @totales[cliente.cliente.nombre] = 0 if @totales[cliente.cliente.nombre].nil?
            @totales[cliente.cliente.nombre] += cliente.azucar_big_bag
            @granTotal[turno.turno.nombre] += cliente.azucar_big_bag
            @granTotal[:totales] += cliente.azucar_big_bag
          end

        end
      end

      @granTotal[:totales] += @totales[:paquetesPapel] + @totales[:paquetesPolietileno] +
        @totales[:industriaBolsas] + @totales[:bolsasAzucarlito] +
        @totales[:bigBagAzucarlito] + @totales[:bigBagDnd]

      respond_to do |format|
        format.html {render :layout => 'informes'}
        format.xls { render :layout => 'informes' }
      end
    else
      redirect_to ver_dia_path(@dia.fecha)
    end
  end

  def produccion_masas_cocidas
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)
    prod = ProduccionMasa.find_by_dia_id(@dia.id)

    @title = "Produccion Masas Cocidas #{l @dia.fecha}"

    @total_masas_cocidas = prod.numero_masas_a + prod.numero_masas_b + prod.numero_masas_c + prod.numero_masas_d

    @total_masas_cocidas = 0 if @total_masas_cocidas.nil?

    if @total_masas_cocidas != 0
      @porcentaje_a = "%01.2f" % ((prod.numero_masas_a.to_f / @total_masas_cocidas) * 100).to_s
      @porcentaje_b = "%01.2f" % ((prod.numero_masas_b.to_f / @total_masas_cocidas) * 100).to_s
      @porcentaje_c = "%01.2f" % ((prod.numero_masas_c.to_f / @total_masas_cocidas) * 100).to_s
      @porcentaje_d = "%01.2f" % ((prod.numero_masas_d.to_f / @total_masas_cocidas) * 100).to_s
    end

    respond_to do |format|
      format.html {render :layout => 'informes'}
      format.xls { render :layout => 'informes' }
    end

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

    @totales = { :crudoProcesado => 0, :tiraje => 0, :promedio_brix => 0, :caudalimetro => 0}

    @brix = {}
    @caudalimetro = {}

    @dia.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }

    @dia.turnos.each do |turno|
      @totales[:crudoProcesado] += turno.insumo.crudoProcesado
      @totales[:tiraje] += turno.insumo.tiraje

      if !turno.analisis.nil?
        @brix[turno.turno.nombre] = turno.analisis.refundicion_brix
        densidad = (0.000018765 * (@brix[turno.turno.nombre] * @brix[turno.turno.nombre]))
          + 0.0003629867 * @brix[turno.turno.nombre] + 1.0011648
        @caudalimetro[turno.turno.nombre] = (turno.insumo.tiraje * densidad * @brix[turno.turno.nombre]) / 100
      end
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

  def analisis
    @dia = Dia.find_by_fecha(Date.parse(params[:fecha]))
    @promedio = Analisis.find_by_turnoDia_id(params[:turno])

    @title = "Analisis #{l @dia.fecha} Turno #{@promedio.turnoDia.turno.nombre}"


    render :layout => 'informes'
  end

  def analisis_promedio_zafra
    @dia = Dia.find_by_fecha(Date.parse(params[:fecha]))

    @zafra = Zafra.where('dia_inicio <= ? and (dia_fin >= ? or dia_fin is null)', @dia.fecha, @dia.fecha).first

    @title = "Promedio de Analisis de la zafra #{l @zafra.dia_inicio}"

    analisis_id_inicial = 0
    fin = @dia.fecha
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
      respond_to do |format|
        format.html {render :layout => 'informes'}
        format.xls { render :layout => 'informes' }
      end


    else
      flash[:warning] = 'No existen datos de analisis ingresados para toda la zafra'
      redirect_to ver_dia_path(@dia.fecha)
    end
  end

  def informe_diario
    @dia = Dia.find_by_fecha(params[:fecha])

    @zafra = Zafra.where('dia_inicio <= ? and (dia_fin >= ? or dia_fin is null)', @dia.fecha, @dia.fecha).first

    @title = "INFORME DIARIO #{l @dia.fecha} ZAFRA #{l @zafra.dia_inicio}"

    @recepcion = Recepcion.new
    @recepcion_zafra = @recepcion.attributes

    @recepcion = @dia.recepcion if !@dia.recepcion.nil?

    @insumo = Insumo.new.attributes
    @insumo_promedio = Insumo.new.attributes
    @insumo_zafra = Insumo.new.attributes
    @insumo_zafra_promedio = Insumo.new.attributes

    @produccion = Produccion.new.attributes
    @produccion_zafra = Produccion.new.attributes

    @insumo_diario = InsumoDiario.new
    @insumo_diario_zafra = InsumoDiario.new.attributes

    @insumo_diario = @dia.insumoDiario if !@dia.insumoDiario.nil?

    @total_azucar_blanco = 0
    @total_azucar_blanco_zafra = 0

    @total_bolsas = 0
    @total_bolsas_zafra = 0
    @total_big_bag = 0
    @total_big_bag_zafra = 0

    total_produccion_clientes = 0
    total_produccion_clientes_zafra = 0

    @insumo['crudoProcesado'] = 0

    @clientes = []

    #CALCULO LOS DATOS DEL DIA ACTUAL
    cantidad = 0
    @dia.turnos.each do |turno|
      @insumo['crudoProcesado'] += turno.insumo.crudoProcesado if !turno.insumo.nil?
      if !turno.produccion.nil?
        @produccion['paquetesPapel'] += turno.produccion.paquetesPapel
        @produccion['paquetesPolietileno'] += turno.produccion.paquetesPolietileno
        @produccion['melaza'] += turno.produccion.melaza
        @produccion['rubio'] += turno.produccion.rubio
        @produccion['industriaBolsas'] += turno.produccion.industriaBolsas
        @produccion['bolsasAzucarlito'] += turno.produccion.bolsasAzucarlito
        @produccion['bigBagAzucarlito'] += turno.produccion.bigBagAzucarlito
        @produccion['bigBagDnd'] += turno.produccion.bigBagDnd

        if !turno.produccion.clientes.nil?
          turno.produccion.clientes.each do |cliente|
            @produccion[cliente.cliente.nombre] = 0 if @produccion[cliente.cliente.nombre].nil?
            @clientes << cliente.cliente.nombre unless @clientes.include?(cliente.cliente.nombre)
            @produccion[cliente.cliente.nombre] += cliente.azucar_big_bag
            total_produccion_clientes += cliente.azucar_big_bag
          end
        end
      end

      cantidad += 1
    end

    @total_bolsas = @produccion['industriaBolsas'] + @produccion['bolsasAzucarlito']
    @total_big_bag = @produccion['bigBagAzucarlito'] + @produccion['bigBagDnd'] + total_produccion_clientes

    @total_azucar_blanco = @produccion['paquetesPapel'] + @produccion['paquetesPolietileno'] +
      @produccion['industriaBolsas'] + @produccion['bolsasAzucarlito'] + @produccion['bigBagAzucarlito'] +
      @produccion['bigBagDnd'] + total_produccion_clientes

    @insumo_promedio['crudoProcesado'] = @insumo['crudoProcesado'] / cantidad if !@insumo['crudoProcesado'].nil? and cantidad > 0

    fin = @dia.fecha
    fin = Date.current if fin.nil?

    @dias = Dia.where('fecha >= ? and fecha <= ?', @zafra.dia_inicio, fin)

    @dias.each do |d|
      @recepcion_zafra['azucar_crudo'] = 0 if @recepcion_zafra['azucar_crudo'].nil?
      @recepcion_zafra['azucar_crudo'] += d.recepcion.azucar_crudo if !d.recepcion.nil?

      @insumo_diario_zafra['cal_viva'] = 0 if @insumo_diario_zafra['cal_viva'].nil?
      @insumo_diario_zafra['cal_viva'] += d.insumoDiario.cal_viva if !d.insumoDiario.nil?
      @insumo_diario_zafra['carbon_activado'] = 0 if @insumo_diario_zafra['carbon_activado'].nil?
      @insumo_diario_zafra['carbon_activado'] += d.insumoDiario.carbon_activado if !d.insumoDiario.nil?
      @insumo_diario_zafra['auxiliar_filtracion'] = 0 if @insumo_diario_zafra['auxiliar_filtracion'].nil?
      @insumo_diario_zafra['auxiliar_filtracion'] += d.insumoDiario.auxiliar_filtracion if !d.insumoDiario.nil?
      @insumo_diario_zafra['acido_clorhidrico'] = 0 if @insumo_diario_zafra['acido_clorhidrico'].nil?
      @insumo_diario_zafra['acido_clorhidrico'] += d.insumoDiario.acido_clorhidrico if !d.insumoDiario.nil?
      @insumo_diario_zafra['lenia_caldera'] = 0 if @insumo_diario_zafra['lenia_caldera'].nil?
      @insumo_diario_zafra['lenia_caldera'] += d.insumoDiario.lenia_caldera if !d.insumoDiario.nil?
      @insumo_diario_zafra['chip'] = 0 if @insumo_diario_zafra['chip'].nil?
      @insumo_diario_zafra['chip'] += d.insumoDiario.chip if !d.insumoDiario.nil?
      @insumo_diario_zafra['aserrin'] = 0 if @insumo_diario_zafra['aserrin'].nil?
      @insumo_diario_zafra['aserrin'] += d.insumoDiario.aserrin if !d.insumoDiario.nil?
      @insumo_diario_zafra['gasoil'] = 0 if @insumo_diario_zafra['gasoil'].nil?
      @insumo_diario_zafra['gasoil'] += d.insumoDiario.gasoil if !d.insumoDiario.nil?

      d.turnos.each do |turno|
        @insumo_zafra['crudoProcesado'] += turno.insumo.crudoProcesado if !turno.insumo.nil?

        if !turno.produccion.nil?
          @produccion_zafra['paquetesPapel'] += turno.produccion.paquetesPapel
          @produccion_zafra['paquetesPolietileno'] += turno.produccion.paquetesPolietileno
          @produccion_zafra['melaza'] += turno.produccion.melaza
          @produccion_zafra['rubio'] += turno.produccion.rubio
          @produccion_zafra['industriaBolsas'] += turno.produccion.industriaBolsas
          @produccion_zafra['bolsasAzucarlito'] += turno.produccion.bolsasAzucarlito
          @produccion_zafra['bigBagAzucarlito'] += turno.produccion.bigBagAzucarlito
          @produccion_zafra['bigBagDnd'] += turno.produccion.bigBagDnd

          if !turno.produccion.clientes.nil?
            turno.produccion.clientes.each do |cliente|
              @produccion_zafra[cliente.cliente.nombre] = 0 if @produccion_zafra[cliente.cliente.nombre].nil?
              @clientes << cliente.cliente.nombre unless @clientes.include?(cliente.cliente.nombre)
              @produccion_zafra[cliente.cliente.nombre] += cliente.azucar_big_bag
              total_produccion_clientes_zafra += cliente.azucar_big_bag
            end
          end
        end
      end

      @total_bolsas_zafra = @produccion_zafra['industriaBolsas'] + @produccion_zafra['bolsasAzucarlito']
      @total_big_bag_zafra = @produccion_zafra['bigBagAzucarlito'] + @produccion_zafra['bigBagDnd'] + total_produccion_clientes_zafra

      @total_azucar_blanco_zafra += @produccion_zafra['paquetesPapel'] + @produccion_zafra['paquetesPolietileno'] + @produccion_zafra['industriaBolsas'] + @produccion_zafra['bolsasAzucarlito'] + @produccion_zafra['bigBagAzucarlito'] + @produccion_zafra['bigBagDnd'] + total_produccion_clientes_zafra
    end

    @total_recepcion = @recepcion.azucar_crudo
    @total_recepcion_zafra = @recepcion_zafra['azucar_crudo']

    @insumo_zafra_promedio['crudoProcesado'] = @insumo_zafra['crudoProcesado'] / @dias.size
    @stock_mat_prima = @total_recepcion_zafra - @insumo_zafra['crudoProcesado']

    @pol_entrada = (@insumo['crudoProcesado'].to_f * @recepcion.polarizacion.to_f) / 100

    @azucar_circulante_actual = ((@insumo['crudoProcesado'].to_f * @recepcion.polarizacion.to_f) / 100) - @total_azucar_blanco.to_f - ((@recepcion.perdida_en_azucar.to_f + @recepcion.azucar_en_melaza.to_f)*@insumo['crudoProcesado'].to_f)/100

    @perdida_en_azucar = (@insumo['crudoProcesado'].to_f * @recepcion.perdida_en_azucar.to_f)/100

    @perdida_en_melaza = (@insumo['crudoProcesado'].to_f * @recepcion.azucar_en_melaza.to_f)/100

    @rendimiento_estimado = 0

    @rendimiento_estimado = ((@total_azucar_blanco_zafra.to_f + @azucar_circulante_actual.to_f)/@insumo_zafra['crudoProcesado'].to_f)*100 if @insumo_zafra['crudoProcesado'] != 0



    respond_to do |format|
      format.html {render :layout => 'informes'}
      format.xls { render :layout => 'informes' }
    end
  end
end
