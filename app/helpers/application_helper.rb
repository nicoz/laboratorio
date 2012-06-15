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

	def time_diff(from_time, to_time)
          %w(year month day hour minute second).map do |interval|
            distance_in_seconds = (to_time.to_time.to_i - from_time.to_time.to_i).round(1)
            delta = (distance_in_seconds / 1.send(interval)).floor
            delta -= 1 if from_time + delta.send(interval) > to_time
            from_time += delta.send(interval)
            delta
        end
end

end
