namespace :db do
	desc "Cargar la base de datos con informacion de muestra"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		admin = Usuario.create!(:nombre => "Nicolas Zuasti",
				:email => "nicozuasti@gmail.com",
				:password => "foobar",
				:password_confirmation => "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			nombre = Faker::Name.name
			email = "ejemplo-#{n+1}@ejemplo.org"
			password = "password"
			Usuario.create!(:nombre => nombre,
				     :email => email,
					:password => password,
					:password_confirmation => password)
		end
	end
end
