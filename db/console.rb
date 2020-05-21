require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()
Artist.delete_all()

customer1 = Artist.new({'first_name' => 'Clint', 'last_name' =>  'Barton'})
customer2 = Artist.new({'first_name' => 'Natasha', 'last_name' => 'Romanov'})
customer1.save()
customer2.save()

order1 = Album.new({
  'artist_id' => customer1.id,
  'title'=> 'Stones',
  'genre'=> 'Rock'
})
order1.save()

order2 = Album.new({
  'artist_id' => customer1.id,
  'title'=> 'Girders',
  'genre'=> 'Metal'
})
order2.save()

order3 = Album.new({
  'artist_id' => customer1.id,
  'title'=> 'Lead',
  'genre'=> 'Heavy metal'
})
order3.save()

binding.pry
nil
