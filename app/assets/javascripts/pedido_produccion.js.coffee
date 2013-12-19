$ ->
  if $('#pedido-produccion').length > 0

    $('.campo').blur ->
      campo = $(this)
      validar(campo, true)

    $('.campo').on('keyup change', _.debounce( ->
      campo = $(this)
      validar(campo, true)
    200))

    $('input[name*="[cliente]"]').on('keyup change', _.debounce( ->
      campo = $(this)
      validarCliente(campo, true)
    200))

    $('input[name*="[cliente]"]').blur ->
      campo = $(this)
      validarCliente(campo, true)
      
    $('#form-pedido-produccion').submit (e) ->
      e.preventDefault()
      formulario = $(this)
      _.delay( ->
        correcto = habilitar()
        if correcto
          formulario.unbind('submit').submit()
      , 1000)


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
  dia = $('#dia').val()
  pedido_produccion = $('#id').val()

  if dia == ''
    dia = 0
  if pedido_produccion == ''
    pedido_produccion = 0

  url = "validar?valor=#{valor}&nombre=#{nombre}&dia=#{dia}&id=#{pedido_produccion}"
  $.ajax
    url: url
    async: sincro
    success: (data) ->
      if data.mensaje != "OK"
        campo.removeClass("success")
        campo.parent().parent().find('.help-inline').remove()
        campo.parent().addClass("field_with_errors")
        campo.addClass("error")
        campo.parent().append("<span class='help-inline mensajes'>#{data.mensaje}</span>")
        habilitar()
      else
        campo.addClass("success")
        campo.removeClass("error")
        campo.parent().removeClass("field_with_errors")
        campo.parent().find('.help-inline').remove()
        habilitar()
    error: ->
      #alert "Ocurrio un error al validar los datos, comuniquese con el administrador del sistema"

validarCliente = (campo, sincro) ->
  valor = campo.val()
  nombre = campo.attr("data-name")
  cliente = campo.parents('.control-group').find('input[name*="[cliente]"]').val()
  produccion = $('input[name*="[pedido_produccion][id]"]').val()

  if cliente == ''
    cliente = 0

  if produccion == ''
    produccion = 0
    
  $.ajax
    url: "/validarclientePedidoProduccion?valor=#{valor}&nombre=#{nombre}&cliente=#{cliente}&produccion=#{produccion}"
    async: sincro
    success: (data) ->
      if data.mensaje != "OK"
        campo.removeClass("success")
        campo.parent().parent().find('.help-inline').remove()
        campo.parent().addClass("field_with_errors")
        campo.addClass("error")
        campo.parent().parent().append("<span class='help-inline pull-right mensajes'>#{data.mensaje}</span>")
      else
        campo.addClass("success")
        campo.removeClass("error")
        campo.parent().removeClass("field_with_errors")
        campo.parent().parent().find('.help-inline').remove()
    
      habilitar()
    error: ->
      #alert "Ocurrio un error al validar los datos, comuniquese con el administrador del sistema"
