require "test_helper"

class ProductTest < ActiveSupport::TestCase

  #test "correct product attributes" do 
  #  p = Product.new
  #  assert p.invalid?
  #  assert p.errors[:title].any?
  #  assert p.errors[:description].any?
  #  assert p.errors[:price].any?
  #  assert p.errors[:image].any?
  #end

  test "product pricing must be >0.01" do
    p = Product.new(title: "tbd", description: "tbd")
    p.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
    
    p.price = -1.0; assert p.invalid?
    p.price =  0.0; assert p.invalid?
    p.price = +1.0; assert p.valid?
  end

  test "product image type must be gif, jpg or png" do 
    p = Product.new(title: "tbd", description: "tbd", price: 1.0)

    p.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
    assert p.valid?
    p.image.attach(io: File.open("test/fixtures/files/lorem.png"), filename: "lorem.png", content_type: "image/png")
    assert p.valid?
    p.image.attach(io: File.open("test/fixtures/files/lorem.gif"), filename: "lorem.gif", content_type: "image/gif")
    assert p.valid?
    p.image.attach(io: File.open("test/fixtures/files/lorem.svg"), filename: "lorem.svg", content_type: "image/svg+html")
    assert p.invalid?
  end

  fixtures :products

  test "product title must be unique" do
    p = Product.new(title: products(:pragprog).title, description: "na", price: 1.0)
    p.image.attach(
      io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
    assert p.invalid?
    assert_equal ["has already been taken"], p.errors[:title]
  end

  test "product title must be unique - avoiding hardcoded ActiveRecord error msg" do
    p = Product.new(title: products(:pragprog).title, description: "na", price: 1.0)
    p.image.attach(
      io: File.open("test/fixtures/files/lorem.jpg"), filename: "lorem.jpg", content_type: "image/jpeg")
    assert p.invalid?
    assert_equal [ I18n.translate("errors.messages.taken")], p.errors[:title]
  end

end
