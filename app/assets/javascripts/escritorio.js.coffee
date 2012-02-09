# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#table-actividades').tablesorter(
		headers:
			4:
				sorter: false
	)

$ ->
  $('#calendar').fullCalendar
    weekends: true,
    editable: false,
    disableDragging: true,
    disableResizing: true,           
    allDayDefault: true,
    monthNames: [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Setiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ],
    monthNamesShort: [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Oct',
      'Nov',
      'Dic'
    ],
    firstDay: 1,
    dayNames: [
    	'Domingo',
    	'Lunes',
    	'Martes',
    	'Miercoles',
    	'Jueves',
    	'Viernes',
    	'Sabado'    	
    ],
    dayNamesShort: [
        'Dom',
    	'Lun',
    	'Mar',
    	'Mier',
    	'Juev',
    	'Vier',
        'Sab' 
    ],
    eventClick: ->
      true
    events: 
      url: 'dias/dias',
      type: 'GET',
      data: 
        fecha: ->          
          	$('#calendar').fullCalendar('getDate')
      error: ->
        alert 'Error leyendo los datos'
