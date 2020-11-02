class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :book_title
      t.text :review

      t.timestamps
    end
  end
end
