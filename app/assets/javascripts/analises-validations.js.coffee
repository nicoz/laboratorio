$ ->
  if $('input[name*="analisis["]').length > 0

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
        if correcto
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
  if nombre == 'azucar_crudo_brix' or nombre == 'azucar_afinada_brix'
    if valor < 90 and valor >= 0 and valor != ''
      mensaje = 'Deberia estar entre 90 y 100'

  if nombre == 'miel_de_afinacion_brix'
    if (valor > 90 or valor < 40) and valor != ''
      mensaje = 'Deberia estar entre 40 y 90'

  if nombre == 'refundicion_brix' or nombre == 'primera_filtracion_brix' or nombre == 'jarabe_brix'
    if (valor > 70 or valor < 50 ) and valor != ''
      mensaje = 'Deberia estar entre 50 y 70'

  if nombre == 'masa_cocida_a_brix' or nombre == 'masa_cocida_b_brix' or nombre == 'masa_cocida_c_brix' or nombre == 'masa_cocida_d_brix' or nombre == 'masa_cocida_e_brix' or nombre == 'masa_afinada_1_brix' or nombre == 'masa_afinada_2_brix'
    if (valor > 95 or valor < 85) and valor != ''
      mensaje = 'Deberia estar entre 85 y 95'

  if nombre == 'miel_a_brix' or nombre == 'miel_b_brix' or nombre == 'miel_c_brix' or nombre == 'miel_d_brix'
    if ( valor > 80 or valor < 65) and valor != ''
      mensaje = 'Deberia estar entre 65 y 80'

  if nombre == 'miel_e_brix' or nombre == 'miel_afinada_1_brix' or nombre == 'miel_afinada_2_brix' or nombre == 'melaza_brix'
    if ( valor > 85 or valor < 65 ) and valor != ''
      mensaje = 'Deberia estar entre 65 y 85'

  if nombre == 'agua_madre_brix'
    if ( valor > 85 or valor < 70 ) and valor != ''
      mensaje = 'Deberia estar entre 70 y 85'


  if mensaje != ''
    campo.parent().parent().removeClass("success")
    campo.parent().parent().find('.label').remove()
    campo.parent().addClass("field_with_warnings")
    campo.parent().parent().addClass("warning")
    campo.parent().parent().append("<span class='label label-warning'>#{mensaje}</span>")
