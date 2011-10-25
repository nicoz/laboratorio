module ApplicationHelper

	#Devuelve el titulo de la pagina
	def title
		base_title = "Sistema de gestion integral de laboratorio"
		
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	def titulo
		primerParte = "Gestion integral de laboratorio"
		
		if @title.nil?
			primerParte
		else
			"#{primerParte} | #{@title}"
		end
	end
end
