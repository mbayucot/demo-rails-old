# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Level 1
categories = ['Home & Garden',
              'Entertainment',
              'Clothing & Accessories',
              'Family',
              'Electronics',
              'Hobbies',
              'Classifieds',
              'Vehicles']
categories.each {|category| Category.create({ name: category })}

# Level 2
home = %w[Tools Furniture Household Garden Appliances]
entertainment = ['Video Games', "Books 'Movies & Music"]
clothing = ['Bags & Luggage', "Women's Clothing & Shoes", "Men's Clothing & Shoes", 'Jewerly & Accessories']
family = ['Bags & Luggage', "Women's Clothing & Shoes", "Men's Clothing & Shoes", 'Jewerly & Accessories']
electronics = ['Electronics & Computers', 'Mobile Phones']
hobbies = ['Bicycles', 'Arts & Crafts', 'Sports & Outdoors', 'Auto Parts', 'Musical Instruments', 'Antiques & Collectibles', ]
classifieds = ['Garage Sale', 'Miscellaneous']
vehicles = %w[Car/Truck Motorcycle Powersport RV/Camper Trailer Boat Commercial/Industrial Other]

home.each {|category| Category.create({ name: category, parent: Category.find_by_name('Home & Garden') })}
entertainment.each {|category| Category.create({ name: category, parent: Category.find_by_name('Entertainment') })}
clothing.each {|category| Category.create({ name: category, parent: Category.find_by_name('Clothing & Accessories') })}
family.each {|category| Category.create({ name: category, parent: Category.find_by_name('Family') })}
electronics.each {|category| Category.create({ name: category, parent: Category.find_by_name('Electronics') })}
hobbies.each {|category| Category.create({ name: category, parent: Category.find_by_name('Hobbies') })}
classifieds.each {|category| Category.create({ name: category, parent: Category.find_by_name('Classifieds') })}
vehicles.each {|category| Category.create({ name: category, parent: Category.find_by_name('Vehicles') })}