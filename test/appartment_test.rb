require 'minitest/autorun'
require 'scrapper'

class TestAppartment1 < MiniTest::Unit::TestCase
  def setup
    @appartment = 
      AppartmentFinder::Appartment.new("http://newyork.craigslist.org/mnh/roo/2954070690.html")
  end

  def test_id
    assert_equal 2954070690, @appartment.id
  end

  def test_title
    assert_equal "$1400 Roommate wanted for 1 bedroom in a 2 bedrm apt utilities wifi included (Lower East Side)", @appartment.title
  end

  def test_body
    assert_equal "Responsible, mature, roommate wanted for 1 bedroom in a 2 bedroom apt,(not a converted 2 bedroom, it is a full 2 bedroom),  in a small, quiet building with a 4 floor walk up. The bedroom is approx. 10 x13, (large enough to fit a queen size bed),  with a walk in double door closet and 2 windows and just freshly painted. $1400 a month including utilities. There is a fully equipped  kitchen and bathroom. Room is unfurnished. Other roomate is a clean, mature, responsible, respectable male who is a kick boxing and birkam yoga instructor . One months rent and one months security deposit required . No pets, no parties, no drug paraphanelia and no couples, please. Long term preferred but short term is okay as well. Please contact me with inquiries and to view. Occupancy beginning immedietly.Will be showing today, Sunday, contact me for viewing.", @appartment.body
  end

  def test_images
    assert_equal ["http://images.craigslist.org/5Lb5Gc5Fb3G13J43N3c4c3a388c12d75c1108.jpg", "http://images.craigslist.org/5N65Y55M63G73Fa3H6c4c63a42e6cab34168e.jpg", "http://images.craigslist.org/5Kd5H45J13G53Ic3Hbc4c80d390376e951230.jpg", "http://images.craigslist.org/5Gb5Fc5Mf3Fb3N43Hdc4caaac7fef6ff8139d.jpg"], @appartment.images
  end

end

class TestAppartment2 < MiniTest::Unit::TestCase
  def setup
    @appartment = 
      AppartmentFinder::Appartment.new("http://newyork.craigslist.org/mnh/roo/2976370859.html")
  end

  def test_id
    assert_equal 2976370859, @appartment.id
  end

  def test_title
    assert_equal "$1250 furnished br has large closet/window, great location (see pics!) (Lower East Side)", @appartment.title
  end

  def test_body
    assert_equal (<<-DOC).strip, @appartment.body
1 bedroom available in spacious 2 bedroom apartment; available NOW  for short term 1to 3 months ( with possible long term).\n\nYour bedroom:\n\nFurnished with full bed, desk, chair, shelves, and big closet.\n\n12 x 10\n\nLarge window\n\nQuiet it is not facing the main st.\n\nThe Apartment:\n\nLarge  living room\n\nDinning room/study table\n\nkitchen\n\nSpacious bathroom\n\nThe Neighborhood:\n\nIs extremely lively filled with things to do at all times of the day. It is literally around the corner from tons of great art galleries, bars, restaurants, coffee shops, and clubs.\n\nThere is a huge Pathmark (supermarket) a block away; it is also steps away from 2 Laundromats.\n\nThe building is less than a block away from the East Broadway stop off of the F Train. \n\n \n\nRoom is available NOW.\n\nRent is 1250$ a mo.  this includes all utilities.\n\n1 month security due on signing.
DOC
  end

  def test_images
    assert_equal ["http://i910.photobucket.com/albums/ac304/londono-susana/CL_living.jpg", "http://i910.photobucket.com/albums/ac304/londono-susana/living2-1.jpg", "http://i910.photobucket.com/albums/ac304/londono-susana/kitchen.jpg", "http://i910.photobucket.com/albums/ac304/londono-susana/photo-1.jpg", "http://i910.photobucket.com/albums/ac304/londono-susana/use_room.jpg"], @appartment.images
  end

end
