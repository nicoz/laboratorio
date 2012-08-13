class AddSoloReportesToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :solo_reportes, :boolean

  end
end
