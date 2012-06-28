module DiaHelper

  def tieneProduccion(fecha)

    dia = Dia.find_by_fecha(fecha)
    resultado = false

    dia.turnos.each do |turno|
        resultado = true if !turno.produccion.nil?
    end

    return resultado

  end

end
