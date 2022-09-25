class CreateAppAdmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :app_admissions do |t|
      t.references :oauth_application, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
