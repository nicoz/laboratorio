class InformesController < ApplicationController
  before_filter :autenticar

  def produccion_turno
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    tieneDatos = true
    @dia.turnos.each do |turno|
        resultado = true if !turno.produccion.nil?
    end

    if tieneDatos
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
end
