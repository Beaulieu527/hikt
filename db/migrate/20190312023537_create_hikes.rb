class CreateHikes < ActiveRecord::Migration
  def change
    create_table :hikes do |t|

      t.timestamps null: false
    end
  end
end
