class Turno < ActiveRecord::Base
	attr_accessible :nombre, :habilitado, :orden
	
	validates :nombre,:uniqueness => { :case_sensitive => false },
			  :presence => true,
			  :length => { :maximum => 50 }
	validates :orden, :uniqueness =>  true,
			  :presence => true,
			  :numericality => { :greater_than => 0, :less_than_or_equal_to => 100000 }
end
