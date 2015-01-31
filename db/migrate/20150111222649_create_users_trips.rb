class CreateUsersTrips < ActiveRecord::Migration
  def change
    create_table :users_trips do |t|
      t.belongs_to :user, index: true
      t.belongs_to :trip, index: true

      t.timestamps null: false
    end
  end
end
