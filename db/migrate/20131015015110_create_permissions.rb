class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions, id: false do |t|
      t.belongs_to :note
      t.belongs_to :user
    end
  end
end
