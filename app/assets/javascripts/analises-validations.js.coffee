$ ->
  if $('input[name*="analisis["]').length > 0

    #pre-segundaValidacion
    $('input[name*="analisis["]').each ->
      segunda_validacion($(this))

    $('input[name*="analisis["]').blur ->
      campo = $(this)
      validar(campo, true)

    $('input[name*="analisis["]').on('keyup change', _.debounce( ->
      campo = $(this)
      validar(campo, true)
    200))

    $('#form-analisis').submit (e) ->
      e.preventDefault()
      formulario = $(this)
      _.delay( ->
        correcto = habilitar()
        bienCorrecto = segundoHabilitar()
        if correcto
          if bienCorrecto
            formulario.unbind('submit').submit()
          else
            confirmado = confirm('Existen valores fuera del rango optimo. Desea guardar igualmente?')
            if confirmado
              formulario.unbind('submit').submit()
      , 1000)

    $('input[name*=brix]').blur ->
      campo = $(this)
      calcular_pza(campo)

    $('input[name*=pol]').blur ->
      campo = $(this)
      calcular_pza(campo)


habilitar = ->
  if $('.error').length > 0
    $('input[type="submit"]').attr "disabled", "disabled"
    false
  else
    $('input[type="submit"]').removeAttr "disabled"
    true

segundoHabilitar = ->
  if $('.warning').length > 0
    false
  else
    true

validar = (campo, sincro) ->
  valor = campo.val()
  nombre = campo.attr("data-name")
  turno = $('#turnoDia_id').val()

  if turno == ''
    turno = 0

  if insumo == ''
    insumo = 0

  $.ajax
    url: "formulario/validar?valor=#{valor}&nombre=#{nombre}&turno=#{turno}"
    async: sincro
    success: (data) ->
      if data.mensaje != "OK"
        campo.parent().parent().removeClass("success")
        campo.parent().parent().find('.label').remove()
        campo.parent().addClass("field_with_errors")
        campo.parent().parent().addClass("error")
        campo.parent().parent().append("<span class='label label-important'>#{data.mensaje}</span>")
      else
        campo.parent().parent().addClass("success")
        campo.parent().parent().removeClass("error")
        campo.parent().removeClass("field_with_errors")
        campo.parent().parent().find('.label').remove()
        segunda_validacion(campo)
      habilitar()
    error: ->
      #alert "Ocurrio un error al validar los datos, comuniquese con el administrador del sistema"

calcular_pza = (campo) ->

  brix = campo.parent().parent().parent().parent().find('input[name*=brix]').val()
  pol = campo.parent().parent().parent().parent().find('input[name*=pol]').val()



  if brix >= 0 and brix != '' and pol >= 0 and pol != ''
    pza = parseFloat((pol / brix)*100).toFixed(2)
  else
    pza = ''

  campo.parent().parent().parent().parent().find('span[id*=pza]').text(pza)
  campo.parent().parent().parent().parent().find('input[name*=pza]').val(pza)

segunda_validacion = (campo) ->
  valor = campo.val()
  nombre = campo.attr("data-name")
  turno = $('#turnoDia_id').val()
  mensaje = ''

  if nombre == 'azucar_a_humedad'
    if (valor > 0.1 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 0.1'

  if nombre == 'azucar_b_humedad' or nombre == 'azucar_c_humedad' or nombre == 'azucar_d_humedad'
    if (valor > 0.06 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 0.06'

  if nombre == 'azucar_crudo_ceniza' or nombre == 'azucar_afinada_ceniza'
    if (valor > 1 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 1'

  if nombre == 'azucar_crudo_invert' or nombre == 'azucar_afinada_invert'
    if (valor > 2 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 2'

  if nombre == 'melaza_invert' or nombre == 'azucar_crudo_humedad' or nombre == 'azucar_afinada_humedad'
    if (valor > 10 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 10'

  if nombre == 'melaza_ceniza'
    if (valor > 25 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 25'

  if nombre == 'azucar_a_color'
    if (valor > 35 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 35'

  if nombre == 'azucar_b_color'
    if (valor > 60 or valor < 35) and valor != ''
      mensaje = 'Deberia estar entre 35 y 60'

  if nombre == 'azucar_c_color'
    if (valor > 90 or valor < 60) and valor != ''
      mensaje = 'Deberia estar entre 60 y 90'

  if nombre == 'azucar_d_color'
    if (valor > 150 or valor < 90) and valor != ''
      mensaje = 'Deberia estar entre 90 y 150'

  if nombre == 'jarabe_color'
    if (valor > 1000 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 1000'

  if nombre == 'azucar_afinada_color' or nombre == 'primera_filtracion_color'
    if (valor > 2000 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 2000'

  if nombre == 'refundicion_color'
    if (valor > 3000 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 3000'

  if nombre == 'azucar_crudo_color' or nombre == 'miel_a_color'
    if (valor > 4000 or valor < 0) and valor != ''
      mensaje = 'Deberia estar entre 0 y 4000'

  if nombre == 'azucar_crudo_ph' or nombre == 'miel_de_afinacion_ph' or nombre == 'azucar_afinada_ph' or nombre == 'refundicion_ph'
    if (valor > 8 or valor < 4) and valor != ''
      mensaje = 'Deberia estar entre 4 y 8'

  if nombre == 'miel_e_ph' or nombre == 'miel_afinada_1_ph' or nombre == 'miel_afinada_2_ph'
    if (valor > 7 or valor < 5) and valor != ''
      mensaje = 'Deberia estar entre 5 y 7'

  if nombre == 'agua_madre_ph' or nombre == 'melaza_ph'
    if (valor > 7 or valor < 5.5) and valor != ''
      mensaje = 'Deberia estar entre 5.5 y 7'

  if nombre == 'masa_afinada_1_ph' or nombre == 'masa_afinada_2_ph' or nombre == 'miel_a_ph' or nombre == 'miel_b_ph' or nombre == 'miel_c_ph' or nombre == 'miel_d_ph'
    if (valor > 8 or valor < 5.5) and valor != ''
      mensaje = 'Deberia estar entre 5.5 y 8'

  if nombre == 'primera_filtracion_ph' or nombre == 'jarabe_ph'
    if (valor > 8 or valor < 6) and valor != ''
      mensaje = 'Deberia estar entre 6 y 8'

  if nombre == 'encalado_alcal'
    if (valor > 12 or valor < 6) and valor != ''
      mensaje = 'Deberia estar entre 6 y 12'

  if nombre == 'masa_cocida_a_ph' or nombre == 'masa_cocida_b_ph' or nombre == 'masa_cocida_c_ph' or nombre == 'masa_cocida_d_ph' or nombre == 'masa_cocida_e_ph'
    if (valor > 8.5 or valor < 6.5) and valor != ''
      mensaje = 'Deberia estar entre 6.5 y 8.5'

  if nombre == 'jugo_carbonatado_ph'
    if (valor > 9 or valor < 7) and valor != ''
      mensaje = 'Deberia estar entre 7 y 9'

  if nombre == 'encalado_ph'
    if (valor > 12 or valor < 10) and valor != ''
      mensaje = 'Deberia estar entre 10 y 12'

  if nombre == 'agua_madre_pol' or nombre == 'melaza_pol'
    if (valor > 65 or valor < 40) and valor != ''
      mensaje = 'Deberia estar entre 40 y 65'

  if nombre == 'miel_de_afinacion_brix'
    if (valor > 90 or valor < 40) and valor != ''
      mensaje = 'Deberia estar entre 40 y 90'

  if nombre == 'miel_afinada_1_pol' or nombre == 'miel_afinada_2_pol'
    if (valor > 65 or valor < 50) and valor != ''
      mensaje = 'Deberia estar entre 50 y 65'

  if nombre == 'refundicion_brix' or nombre == 'primera_filtracion_brix' or nombre == 'jarabe_brix' or nombre == 'refundicion_pol' or nombre == 'primera_filtracion_pol' or nombre == 'jarabe_pol'
    if (valor > 70 or valor < 50 ) and valor != ''
      mensaje = 'Deberia estar entre 50 y 70'

  if nombre == 'miel_d_pol' or nombre == 'miel_e_pol'
    if ( valor < 60 or valor > 75) and valor != ''
      mensaje = 'Deberia estar entre 60 y 75'

  if nombre == 'miel_de_afinacion_pol'
    if ( valor < 60 or valor > 80) and valor != ''
      mensaje = 'Deberia estar entre 60 y 80'

  if nombre == 'miel_a_brix' or nombre == 'miel_b_brix' or nombre == 'miel_c_brix' or nombre == 'miel_d_brix' or nombre == 'miel_a_pol' or nombre == 'miel_b_pol' or nombre == 'miel_c_pol'
    if ( valor > 80 or valor < 65) and valor != ''
      mensaje = 'Deberia estar entre 65 y 80'

  if nombre == 'miel_e_brix' or nombre == 'miel_afinada_1_brix' or nombre == 'miel_afinada_2_brix' or nombre == 'melaza_brix'
    if ( valor > 85 or valor < 65 ) and valor != ''
      mensaje = 'Deberia estar entre 65 y 85'

  if nombre == 'agua_madre_brix'
    if ( valor > 85 or valor < 70 ) and valor != ''
      mensaje = 'Deberia estar entre 70 y 85'

  if nombre == 'masa_afinada_2_pol'
    if ( valor > 83 or valor < 70 ) and valor != ''
      mensaje = 'Deberia estar entre 70 y 83'

  if nombre == 'masa_afinada_1_pol'
    if ( valor > 83 or valor < 73 ) and valor != ''
      mensaje = 'Deberia estar entre 73 y 83'

  if nombre == 'masa_cocida_e_pol'
    if ( valor < 75 or valor > 85) and valor != ''
      mensaje = 'Deberia estar entre 75 y 85'

  if nombre == 'masa_cocida_a_brix' or nombre == 'masa_cocida_b_brix' or nombre == 'masa_cocida_c_brix' or nombre == 'masa_cocida_d_brix' or nombre == 'masa_cocida_e_brix' or nombre == 'masa_afinada_1_brix' or nombre == 'masa_afinada_2_brix' or nombre == 'masa_cocida_a_pol' or nombre == 'masa_cocida_b_pol' or nombre == 'masa_cocida_c_pol' or nombre == 'masa_cocida_d_pol'
    if (valor > 95 or valor < 85) and valor != ''
      mensaje = 'Deberia estar entre 85 y 95'

  if nombre == 'azucar_crudo_brix' or nombre == 'azucar_afinada_brix' or nombre == 'azucar_crudo_pol' or nombre == 'azucar_afinada_pol'
    if valor < 90 and valor >= 0 and valor != ''
      mensaje = 'Deberia estar entre 90 y 100'

  if mensaje != ''
    campo.parent().parent().removeClass("success")
    campo.parent().parent().find('.label').remove()
    campo.parent().addClass("field_with_warnings")
    campo.parent().parent().addClass("warning")
    campo.parent().parent().append("<span class='label label-warning'>#{mensaje}</span>")
  else
    campo.parent().parent().find('.label-warning').remove()
    campo.parent().removeClass("field_with_warnings")
    campo.parent().parent().removeClass("warning")
