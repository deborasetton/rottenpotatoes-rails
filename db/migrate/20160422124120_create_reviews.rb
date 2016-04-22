class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :moviegoer
      t.references :movie
      t.integer    :potatoes
      t.text       :comments
    end
  end
end
