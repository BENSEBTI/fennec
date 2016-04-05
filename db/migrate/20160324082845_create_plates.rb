class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.string :siteid
      t.string :camid
      t.string :plate
      t.string :confidence
      t.string :process
      t.string :x
      t.string :y
      t.string :uuid

      t.timestamps null: false
    end
  end
end
