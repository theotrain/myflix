# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Monk", description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg" )

Video.create(title: "Family Guy", description: "Eh mah gawd, its the greatest show of all times.  Suh fannah! fldlskjfl skfjlsdkjf lsdkfj kjkj kj !", small_cover_url: "family_guy.jpg", large_cover_url: "family_guy_large.jpg" )
Video.create(title: "Futurama", description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.", small_cover_url: "futurama.jpg", large_cover_url: "futurama_large.jpg" )

Video.create(title: "South Park", description: "Follows the misadventures of four irreverent grade-schoolers in the quiet, dysfunctional town of South Park, Colorado.", small_cover_url: "south_park.jpg", large_cover_url: "south_park_large.jpg" )

Category.create(name: "TV Comedies")
Category.create(name: "TV Dramas")
Category.create(name: "Reality TV")

Video.find_each do |v|
  v.category_id = 1
  v.save
end

Review.create(user_id: 1,  video_id: 8,  body: "This is the finest show ever made by grade-school animators with ALS", rating: 3)
Review.create(user_id: 1,  video_id: 8,  body: "Respect my Authoritaaaaaaahhhhhhhh", rating: 2)
Review.create(user_id: 1,  video_id: 8,  body: "They killed Kenny.  You Bastards! They killed Kenny.  You Bastards! They killed Kenny.  You Bastards! They killed Kenny.  You Bastards! They killed Kenny.  You Bastards! They killed Kenny.  You Bastards! ", rating: 5)
