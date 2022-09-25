class AddConstratintsOnDobToUsers < ActiveRecord::Migration[6.0]
  def change
    default_dob = Date.new(1970,1,1)
    User.where(dob: nil).update_all(dob: default_dob)

    change_column_default :users, :dob, from: nil, to: default_dob
    change_column_null :users, :dob, false
  end
end
