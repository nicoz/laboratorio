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
