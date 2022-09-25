class CreateServiceAdmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :service_admissions do |t|
      t.belongs_to :service
      t.belongs_to :user
      t.integer :access_level
      t.timestamps
    end
  end
end
