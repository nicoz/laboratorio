# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#table-turnos').tablesorter(
		sortList: [[0,0],[1,0]]
		headers:
			2:
				sorter: false
	)
