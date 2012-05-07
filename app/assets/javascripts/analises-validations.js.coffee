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
	if $('input.error').length > 0
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

calcular_pza = (campo) ->
	
	brix = campo.parent().parent().parent().parent().find('input[name*=brix]').val()
	pol = campo.parent().parent().parent().parent().find('input[name*=pol]').val()
	

	
	if brix >= 0 and brix != '' and pol >= 0 and pol != ''
		pza = parseFloat((pol / brix)*100).toFixed(2)
	else
		pza = ''
	
	campo.parent().parent().parent().parent().find('span[id*=pza]').text(pza)
	campo.parent().parent().parent().parent().find('input[name*=pza]').val(pza)


