class AddPrimaryKeyToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :id, :primary_key
  end
end
