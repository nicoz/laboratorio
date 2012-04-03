# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	if $('input[name*="[insumo]"]').length > 0

		$('input[name*="[turno]"]').blur ->
			campo = $(this)
			validar(campo, true)

		$('input[name*="[turno]"]').on('keyup change', _.debounce( ->
			campo = $(this)
			validar(campo, true)
		200))

		$('#form-insumos').submit (e) ->
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
	turno = campo.siblings('input[name*="[turnoDia]"]').val()
	insumo = campo.siblings('input[name*="[insumo]"]').val()
	
	if turno == ''
		turno = 0

	if insumo == ''
		insumo = 0

	$.ajax
		url: "validar?crudoProcesado=#{valor}&turno=#{turno}&insumo=#{insumo}"
		async: sincro
		success: (data) ->
			if data.mensaje != "OK"
				campo.removeClass("success")
				campo.parent().parent().find('.help-inline').remove()
				campo.parent().addClass("field_with_errors")
				campo.addClass("error")
				campo.parent().parent().append("<span class='help-inline offset3 span3 mensajes'>#{data.mensaje}</span>")
			else
				campo.addClass("success")
				campo.removeClass("error")
				campo.parent().removeClass("field_with_errors")
				campo.parent().parent().find('.help-inline').remove()
		
			habilitar()
		error: ->
			#alert "Ocurrio un error al validar los datos, comuniquese con el administrador del sistema"

