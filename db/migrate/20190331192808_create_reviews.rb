class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reveiws do |t|
      t.integer :hike_id
      t.integer :user_id
      t.string :content
    end
  end
end
