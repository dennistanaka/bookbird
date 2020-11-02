class AddImageToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :book_cover, :string
  end
end
