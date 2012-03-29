# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	if $('input[name*="[produccion]"]').length > 0

		$('input[name*="[turno]"]').blur ->
			campo = $(this)
			valor = campo.val()
			nombre = campo.attr("data-name")
			turno = campo.parents('.span6').find('input[name*="[turnoDia]"]').val()
			insumo = campo.parents('.span6').find('input[name*="[produccion]"]').val()

			if turno == ''
				turno = 0
		
			if insumo == ''
				insumo = 0
			
			
			$.ajax
				url: "validar?valor=#{valor}&nombre=#{nombre}&turno=#{turno}&produccion=#{insumo}"
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

habilitar = ->
	if $('input.error').length > 0
		$('input[type="submit"]').attr "disabled", "disabled"
	else
		$('input[type="submit"]').removeAttr "disabled"

