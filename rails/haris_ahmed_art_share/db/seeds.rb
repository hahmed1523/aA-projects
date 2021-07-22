# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.destroy_all

user1, user2, user3 = User.create([{username: 'test1'}, {username: 'test2'}, {username: 'test3'}])
art1, art2, art3, art4, art5, art6 = Artwork.create([{title: 'testart1', image_url: 'testart1.com', artist_id: user1.id},
                {title: 'testart1_a', image_url: 'testart1_a.com', artist_id: user1.id},
                {title: 'testart1_b', image_url: 'testart1_b.com', artist_id: user1.id},
                {title: 'testart2', image_url: 'testart2.com', artist_id: user2.id},
                {title: 'testart3', image_url: 'testart3.com', artist_id: user3.id},
                {title: 'testart3_a', image_url: 'testart3_a.com', artist_id: user3.id}])

share1, share2, share3, share4, share5, share6, share7, share8 = ArtworkShare.create([{artwork_id: art1.id, viewer_id: user2.id},
                    {artwork_id: art1.id, viewer_id: user3.id},
                    {artwork_id: art2.id, viewer_id: user2.id},
                    {artwork_id: art2.id, viewer_id: user3.id},
                    {artwork_id: art3.id, viewer_id: user2.id},
                    {artwork_id: art3.id, viewer_id: user3.id},
                    {artwork_id: art4.id, viewer_id: user1.id},
                    {artwork_id: art4.id, viewer_id: user3.id}])