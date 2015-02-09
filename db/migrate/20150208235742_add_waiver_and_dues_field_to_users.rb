class AddWaiverAndDuesFieldToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :waiver_signed, :integer
  	add_column :users, :dues_paid, :integer
  	add_column :users, :waiver_signed_date, :datetime
  	add_column :users, :dues_paid_date, :datetime
  	add_column :users, :ec_name, :string
  	add_column :users, :ec_type, :string
  	add_column :users, :ec_phone1, :string
  	add_column :users, :ec_phone2, :string
  	add_column :users, :ec_email, :string
  end
end
