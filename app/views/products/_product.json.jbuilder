json.extract! product, :id, :name, :price, :image, :summery, :created_at, :updated_at
json.url product_url(product, format: :json)
