class AddBlacklistedToPlate < ActiveRecord::Migration
  def change
    add_column :plates, :blacklisted, :string
  end
end
