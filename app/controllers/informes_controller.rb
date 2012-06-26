class InformesController < ApplicationController
  before_filter :autenticar

  def produccion_turno
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)

    # :paquetesPapel, :paquetesPolietileno , :melaza,
    # :rubio, :industriaBolsas, :bolsasAzucarlito, :bigBagAzucarlito,
    # :bigBagDnd

    @totales = {:paquetesPapel => 0, :paquetesPolietileno => 0, :melaza => 0,
      :rubio => 0, :industriaBolsas => 0, :bolsasAzucarlito => 0, :bigBagAzucarlito => 0,
      :bigBagDnd => 0
    }

    @clientes = []

    turno1 = @dia.turnos.first
    turno1.produccion.clientes.each do |cliente|
      @totales[cliente.cliente.nombre] = 0
      @clientes << cliente.cliente.nombre

    end
    @dia.turnos.each do |turno|
      @totales[:paquetesPapel] += turno.produccion.paquetesPapel
      @totales[:paquetesPolietileno] += turno.produccion.paquetesPolietileno
      @totales[:melaza] += turno.produccion.melaza
      @totales[:rubio] += turno.produccion.rubio
      @totales[:industriaBolsas] += turno.produccion.industriaBolsas
      @totales[:bolsasAzucarlito] += turno.produccion.bolsasAzucarlito
      @totales[:bigBagAzucarlito] += turno.produccion.bigBagAzucarlito
      @totales[:bigBagDnd] += turno.produccion.bigBagDnd


      turno.produccion.clientes.each do |cliente|
        @totales[cliente.cliente.nombre] += cliente.azucar_big_bag
      end
    end

    render :layout => 'informes'

  end
end
