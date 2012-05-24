$ ->
  if $('#form-produccion-masas').length > 0
    $('.campo').blur ->
      campo = $(this)
      validar(campo, true)

    $('.campo').on('keyup change', _.debounce( ->
      campo = $(this)
      validar(campo, true)
    200))

    $('#form-recepcion').submit (e) ->
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
  dia = $('input[name*=dia]').val()
  recepcion = $('#id').val()

  if dia == ''
    dia = 0
  if recepcion == ''
    recepcion = 0

  url = "validar?valor=#{valor}&nombre=#{nombre}&dia=#{dia}&id=#{recepcion}"
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
