class TurnoDia < ActiveRecord::Base
	attr_accessible :turno_id, :estado

	belongs_to :dia
	belongs_to :turno
	
	validates :turno_id, :uniqueness => {:scope => :dia_id},
			     :presence => true
	validates :dia_id,   :presence => true
	validates :estado,   :presence => true
	
end
