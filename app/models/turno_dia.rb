class TurnoDia < ActiveRecord::Base
	attr_accessible :turno_id, :estado

	belongs_to :dia
	belongs_to :turno
	has_one :insumo, :foreign_key => 'turnoDia_id'
	has_one :produccion, :foreign_key => 'turnoDia_id'
	
	accepts_nested_attributes_for :insumo
	
	validates :turno_id, :uniqueness => {:scope => :dia_id},
			     :presence => true
	validates :dia_id,   :presence => true

end
