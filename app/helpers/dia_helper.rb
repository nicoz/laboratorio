module DiaHelper

  def tieneProduccion(fecha)

    dia = Dia.find_by_fecha(fecha)
    resultado = false

    dia.turnos.each do |turno|
        resultado = true if !turno.produccion.nil?
    end

    return resultado

  end

  def tiene_recepcion(fecha)

    dia = Dia.find_by_fecha(fecha)

    return !dia.recepcion.nil?
  end

  def tiene_produccion_masas(fecha)
    dia = Dia.find_by_fecha(fecha)

    return !dia.produccionMasa.nil?
  end

  def tiene_insumos_diarios(fecha)
    dia = Dia.find_by_fecha(fecha)

    return !dia.insumoDiario.nil?
  end

  def tiene_insumos_por_turno(fecha)
    dia = Dia.find_by_fecha(fecha)
    resultado = false

    dia.turnos.each do |turno|
        resultado = true if !turno.insumo.nil?
    end

    return resultado
  end
end
