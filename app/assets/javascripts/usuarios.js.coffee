# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
validar = (elemento) ->
	elemento.parent().children("span").remove()
	texto = elemento.parent().children(".message").text()
	sp = "<span class='help-inline'>#{texto}</span>"
	if texto != ""
		elemento.parent().append(sp)
		elemento.addClass("error")
		elemento.parents(".clearfix").removeClass("success")
		elemento.parents(".clearfix").addClass("error")
	else
		elemento.removeClass("error")
		elemento.parents(".clearfix").removeClass("error")
		if elemento.val()
			elemento.parents(".clearfix").addClass("success")
	false
$ ->
	$('#table-usuarios').tablesorter(
		sortList: [[0,0],[1,0]]
		headers:
			2:
				sorter: false
	)
	$("input").blur ->
		elemento = $(this)
		validar elemento
		
	$("#usuario_password_confirmation").blur ->
		elemento = $("#usuario_password")
		validar elemento
