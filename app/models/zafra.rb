class Zafra < ActiveRecord::Base
  attr_accessible :dia_inicio, :dia_fin

  validates :dia_inicio, :presence => true, :uniqueness => true
  validates :dia_fin, :uniqueness => true

  scope :activa, where('dia_fin = ?', nil)

  def to_s
    "Zafra: l #{self.dia_inicio}"
  end
end
