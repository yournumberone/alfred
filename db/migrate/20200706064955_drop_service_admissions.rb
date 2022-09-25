class DropServiceAdmissions < ActiveRecord::Migration[6.0]
  def change
    drop_table :service_admissions
  end
end
