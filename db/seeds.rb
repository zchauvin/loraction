# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.destroy_all
Task.destroy_all
Level.destroy_all

water = Category.create(
	name: 'Water', 
	description: 'This is one of the most precious resources on Earth,
				  and yet humans waste it with reckless abandon. Help 
				  preserve this gift by taking simple steps to ensure 
				  that the people of today and the future can have clean,
				  potable, and accessible water!')

# carbon = Category.create(
# 	name: 'Carbon',
# 	description: 'Wasted carbon sucks dude!')

shower = Task.create(
	name: 'showering',
	description: 'This is a great way to get started on conserving water!
				  By focusing on the length and frequency of your showers, 
				  you can save a huge amount of water!', 
	category_id: water.id)

get_started = Tip.create(
	description: 'None of this standing around stuff! Once you get in the shower,
				  it\'s go time, so put in your shampoo and get started!',
	level_id: shower.id 
	)

shampoo = Tip.create(
	description: "It's easy to get carried away with shampooing! Once you start, sing
				  a song like Happy Birthday and once it's done, it's time to move on 
				  to body soap!",
	level_id: shower.id
	)


laundry = Task.create(
	name: 'laundry',
	description: 'This is a longer term way to reduce your household water
				  usage by orders of magnitude! By doing laundry less frequently, 
				  you can make a huge difference!', 
	category_id: water.id)

red_meat = Task.create(
	name: 'red_meat',
	description: 'Believe it or not, red meat is actually one of the biggest
				  producers of green house gas! By working to reduce the amount of this 
				  food that you intake, you can cut your water usage by huge amounts!', 
	category_id: water.id)


s_freq = Level.create(
	name: 'shower_frequency',
	unit: 'average times per day, decimal',
	task_id: shower.id)

length = Level.create(
	name: 'shower_length',
	unit: 'minutes',
	task_id: shower.id)

l_freq = Level.create(
	name: 'laundry_frequency',
	unit: 'times per month',
	task_id: laundry.id)
