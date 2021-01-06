# 30.times do |i|
# 	Product.create!(
# 		name: "Flower #{i+1}",
# 		price: "#{i*100}",
# 		image: "/noimage.png",
# 		summery: "Flower #{i+1}：商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。"
# 	)
# end


5.times do |i|
	Order.create!(
		user_id: 10,
		product_id: "#{i+2}",
		number: "#{i+10}",
		count: "#{1}",
		total_price: "#{i*1000}"
	)
end
