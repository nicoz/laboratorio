class ProduccionMasa < ActiveRecord::Base
  attr_accessible :numero_masas_a, :numero_masas_b, :numero_masas_c, :numero_masas_d, :dia_id

  belongs_to :dia

  validates :numero_masas_a, :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 20 }
  validates :numero_masas_b, :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 20 }
  validates :numero_masas_c, :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 20 }
  validates :numero_masas_d, :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 20 }

  validates :dia_id, :presence => true, :uniqueness => true
end
