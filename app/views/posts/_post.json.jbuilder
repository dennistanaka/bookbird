json.extract! post, :id, :book_title, :review, :created_at, :updated_at
json.url post_url(post, format: :json)
