Category.create(name: 'Metal Waste')
Category.create(name: 'Wood Waste')

Subcategory.create(name: 'Iron Waste', category_id: '1')
Subcategory.create(name: 'Brass Waste', category_id: '1')
Subcategory.create(name: 'Gold Waste', category_id: '1')
Subcategory.create(name: 'Oak Waste', category_id: '2')
Subcategory.create(name: 'Birch Waste', category_id: '2')
Subcategory.create(name: 'Mahogany Waste', category_id: '2')

trader1 = Trader.create(username:'General Industries Ltd', email: 'a@gmail.com', password: 'password')
trader2 = Trader.create(username:'Tom, Dick, Harry and Sons', email: 'b@gmail.com', password: 'password')
trader3 = Trader.create(username:'Joe Bloggs Factory Ltd', email: 'c@gmail.com', password: 'password')
trader4 = Trader.create(username:'Jim\'s Forestry Plant ', email: 'd@gmail.com', password: 'password')
trader5 = Trader.create(username:'E', email: 'e@gmail.com', password: 'password')
admin = Trader.create(username:'Admin', email: 'admin@gmail.com', password: 'password', admin:'true')
trader7 = Trader.create(username: Faker::Company.name, email: 'f@gmail.com', password: 'password')
trader8 = Trader.create(username: Faker::Company.name, email: 'g@gmail.com', password: 'password')
trader9 = Trader.create(username: Faker::Company.name, email: 'h@gmail.com', password: 'password')

# status 1: approved
# status 2: pending approval
# status 3: declined
document = File.new("#{Rails.root}/app/assets/test.pdf")
trader1.approved_buy_cats.create(buy_cat_id: '3',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader1.approved_buy_cats.create(buy_cat_id: '2',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader2.approved_buy_cats.create(buy_cat_id: '2',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader3.approved_buy_cats.create(buy_cat_id: '5',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader4.approved_buy_cats.create(buy_cat_id: '6',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader5.approved_buy_cats.create(buy_cat_id: '1',status:'2', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader5.approved_sell_cats.create(sell_cat_id: '1',status:'3', document: File.new("#{Rails.root}/app/assets/test.pdf"))

trader1.approved_sell_cats.create(sell_cat_id: '1',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader2.approved_sell_cats.create(sell_cat_id: '2',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader1.approved_sell_cats.create(sell_cat_id: '3',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader2.approved_sell_cats.create(sell_cat_id: '1',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader2.approved_sell_cats.create(sell_cat_id: '3',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader3.approved_sell_cats.create(sell_cat_id: '3',status:'1', document: document)
trader3.approved_sell_cats.create(sell_cat_id: '6',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader4.approved_sell_cats.create(sell_cat_id: '4',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))
trader4.approved_sell_cats.create(sell_cat_id: '5',status:'1', document: File.new("#{Rails.root}/app/assets/test.pdf"))

Post.create(name: 'Scrap shipyard iron', description: 'Scrap iron from our shipyard on the Glasgow Clyde',
            price: '5000.00', private: 'false',subcategory_id: '1',active: 'true', auction:'true',
            delivery: 'true', trader_id: '1',quantity:"1 tonne", provide_samples: 'true',
            image: File.new("#{Rails.root}/app/assets/images/iron.jpg"), delivery_days: '10',
            created_at: Time.now - 6.days - 16.hours,
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state, postcode: Faker::Address.postcode)

Post.create(name: 'Brass cuts', description: 'Brass cuts from handmade musical instrument shop',
            price: '100.00', private: 'false',subcategory_id: '2',active: 'true', auction:'true',
            delivery: 'false', trader_id: '2',quantity:"10 kg", provide_samples: 'true',
            image: File.new("#{Rails.root}/app/assets/images/Brass.jpg"),
            created_at: Time.now - 6.days - 23.hours - 59.minutes, highest_bidder: '1',  no_of_bids: '1',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state, postcode: Faker::Address.postcode)

Post.create(name: 'Gold nuggets', description: 'Scraps from jewellery shop, 9 ct',
            price: '99.99', private: 'true',subcategory_id: '3',active: 'true', auction:'false',
            delivery: 'true', trader_id: '1',quantity:"50 g", provide_samples: 'true',
            image: File.new("#{Rails.root}/app/assets/images/gold.jpg"), delivery_days: '3',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Iron shavings', description: 'Shavings of iron from out factory production line',
            price: '20.00', private: 'false',subcategory_id: '1',active: 'true',
            delivery: 'false', trader_id: '2',quantity:"1 kg", auction:'false',
            image: File.new("#{Rails.root}/app/assets/images/iron.jpg"),
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Ship hull Iron', description: 'Iron from the hull of a decommissioned ship',
            price: '450.00', private: 'false',subcategory_id: '1',active: 'true', auction:'true',
            delivery: 'true', trader_id: '1',quantity:"3 tonnes",
            image: File.new("#{Rails.root}/app/assets/images/iron.jpg"), delivery_days: '9',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Gold chains', description: '21 ct gold chains',
            price: '250.00', private: 'true',subcategory_id: '3',active: 'true', auction:'false',
            delivery: 'true', trader_id: '2',quantity:"10 chains", provide_samples: 'true',
            image: File.new("#{Rails.root}/app/assets/images/gold.jpg"), delivery_days: '4',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Oak logs', description: 'Logs from our forestry plant too small for general sale',
            price: '50.00', private: 'false',subcategory_id: '4',active: 'true',
            delivery: 'true', trader_id: '4',quantity:"15 kg", auction:'false',
            image: File.new("#{Rails.root}/app/assets/images/oak.jpg"), delivery_days: '5',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Test item 1', description: 'This is a test item',
            price: '127.50', private: 'false',subcategory_id: '4',active: 'true',
            delivery: 'true', trader_id: '4',quantity:"20 kg", auction:'false',
            image: File.new("#{Rails.root}/app/assets/images/oak.jpg"), delivery_days: '3',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Test item 2', description: 'This is a test item',
            price: '66.60', private: 'true',subcategory_id: '5',active: 'true', auction:'false',
            delivery: 'false', trader_id: '4',quantity:"2 kg", provide_samples: 'true',
            image: File.new("#{Rails.root}/app/assets/images/birch.jpg"),
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Gold Ring', description: 'a 9ct gold ring',
            price: '10.00', private: 'true',subcategory_id: '3',active: 'true',
            delivery: 'true', trader_id: '3',quantity:"10 chains", auction:'false',
            image: File.new("#{Rails.root}/app/assets/images/gold.jpg"), delivery_days: '4',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Test Item 3', description: 'This is a test item',active: 'false',
            price: '135.00',subcategory_id: '6', trader_id: '3',quantity:"1 kg", delivery: 'false',private: 'false',
            image: File.new("#{Rails.root}/app/assets/images/mahogany.jpg"), auction:'false',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Post.create(name: 'Test item with really long names for every field',
            description: 'This is a test item with really long names for every field so that we can test wrapping',
            price: '99999999.99', private: 'false',subcategory_id: '6',active: 'true',auction:'false',
            delivery: 'true', trader_id: '3',quantity:"Lots and lots and lots and lots",
            image: File.new("#{Rails.root}/app/assets/images/mahogany.jpg"),
            delivery_days: '50', report: 'true',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state,postcode: Faker::Address.postcode)

Trade.create(time: Time.now(), post_id: '11',
             trader_id: '4', feedback: 'Excellent service, thanks!',
             line1: Faker::Address.street_address, city: Faker::Address.city,
             county: Faker::Address.state,postcode: Faker::Address.postcode)

100.times do
  Post.create(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.sentence,
          quantity: Faker::Lorem.sentence(4,false,2),
          price: Faker::Commerce.price,
          trader_id: Faker::Number.between(7, 9),
          private: rand(2) == 1 ? 'true' : 'false',
          delivery: rand(2) == 1 ? 'true' : 'false',
          active: 'false',
          report: 'false',
          provide_samples: 'false',
          image: File.new("#{Rails.root}/app/assets/images/recycling.jpg"),
          subcategory_id: Faker::Number.between(1, 6),
          delivery_days: Faker::Number.between(2, 14),
          line1: Faker::Address.street_address,
          city: Faker::Address.city,
          county: Faker::Address.state,
          postcode: Faker::Address.postcode
  )
end

for i in 14..112
  Trade.create(
    time: Faker::Time.between(DateTime.now - 100, DateTime.now),
    post_id: i.to_s,
    trader_id: Faker::Number.between(7, 9),
    feedback: Faker::Lorem.sentence,
    line1: Faker::Address.street_address,
    city: Faker::Address.city,
    county: Faker::Address.state,
    postcode: Faker::Address.postcode
  )
end

Post.create(name: 'Test item 4', description: 'This is a test item', price: '5.99', private: 'false',
            subcategory_id: '2', active: 'true', quantity: '100g', delivery: 'true', auction:'false',
            image: File.new("#{Rails.root}/app/assets/images/Brass.jpg"),
            delivery_days: '5', report: 'false',trader_id: '1',
            line1: Faker::Address.street_address, city: Faker::Address.city,
            county: Faker::Address.state, postcode: Faker::Address.postcode
)