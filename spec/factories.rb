# Utilizando el simbolo ":usuario", Factory Girl simula usar el modelo Usuario
Factory.define :usuario do |usuario|
	usuario.nombre			"Nicolas Zuasti"
	usuario.email			"nicozuasti@gmail.com"
	usuario.password		"foobar"
	usuario.password_confirmation	"foobar"
end

Factory.sequence :email do |n|
	"persona-#{n}@ejemplo.org"
end
