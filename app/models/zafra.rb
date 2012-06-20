class Zafra < ActiveRecord::Base
  attr_accessible :dia_inicio, :dia_fin

  validates :dia_inicio, :presence => true, :uniqueness => true
  validates :dia_fin, :uniqueness => true

  validate :dia_inicial_usado
  validate :dia_fin_usado

  scope :activa, where('dia_fin = ?', nil)

  def to_s
    "Zafra: l #{self.dia_inicio}"
  end

  private
    def dia_inicial_usado
      zafras = Zafra.where("dia_inicio <= ? and dia_fin >= ? and id != ?",self.dia_inicio, self.dia_inicio, self.id).count
      errors.add(:dia_inicio, "La fecha esta incluida dentro de otra zafra") if zafras > 0
    end

    def dia_fin_usado
      zafras = Zafra.where("dia_inicio <= ? and dia_fin >= ? and id != ?",self.dia_fin, self.dia_fin, self.id).count
      errors.add(:dia_fin, "La fecha esta incluida dentro de otra zafra") if zafras > 0
    end

end
