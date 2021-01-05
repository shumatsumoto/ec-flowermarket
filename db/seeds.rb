30.times do |i|
	Product.create!(
		name: "Flower #{i+1}",
		price: "#{i*100}",
		image: "/noimage.png",
		summery: "Flower #{i+1}：商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。商品の説明です。"
	)
end
