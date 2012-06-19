# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.link_zafra').click (e) ->
    e.preventDefault()
    link = $(this)
    url = link.attr('href')
    confirmado = true

    if link.attr('id') == 'fin_zafra'
      confirmado = confirm "Seguro que desea finalizar la Zafra?"

    if confirmado
     $.ajax
      url: url
      success: (data) ->
        mensaje = data.mensaje
        if mensaje == 'OK'
          location.reload()
        else
          link.parent().parent().append("""<div class="alert">
            <button class="close" data-dismiss="alert">×</button>
            <strong>Atencion!</strong> #{mensaje}</div>
            """)


  if $('#zafra').length > 0
    $('.fecha').datepicker(
      dateFormat: 'dd/mm/yy',
      onClose: ->
        campo = $(this)
        validar(campo, true)
    )

    $('#form-zafra').submit (e) ->
      e.preventDefault()
      formulario = $(this)
      _.delay( ->
        correcto = habilitar()
        if correcto
          formulario.unbind('submit').submit()
      , 1000)


habilitar = ->
  if $('input.error').length > 0
    $('input[type="submit"]').attr "disabled", "disabled"
    false
  else
    $('input[type="submit"]').removeAttr "disabled"
    true

validar = (campo, sincro) ->
  valor = campo.val()
  nombre = campo.attr("data-name")
  zafra = $("#zafra").val()

  if zafra == ''
    zafra = 0

  $.ajax
    url: "../../validar-zafras?valor=#{valor}&nombre=#{nombre}&zafra=#{zafra}"
    async: sincro
    success: (data) ->
      if data.mensaje != "OK"
        campo.removeClass("success")
        campo.parent().find('.label').remove()
        campo.parent().addClass("field_with_errors")
        campo.addClass("error")
        campo.parent().append("<span class='label label-important'>#{data.mensaje}</span>")
      else
        campo.addClass("success")
        campo.removeClass("error")
        campo.parent().removeClass("field_with_errors")
        campo.parent().find('.help-inline').remove()

      habilitar()
    error: ->
