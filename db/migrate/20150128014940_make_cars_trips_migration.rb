class MakeCarsTripsMigration < ActiveRecord::Migration
  def change
  	create_table :carpools do |t|
  		t.belongs_to :trip, index: true
  		t.belongs_to :user, index: true
		
  		t.timestamps null: false
  	end
  end
end
