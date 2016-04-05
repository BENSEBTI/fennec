class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
    	t.string :platen
    	t.string :comment
    	t.string :vtype
    	t.string :cmodel

      t.timestamps null: false
    end
  end
end
