require "test_helper"

class ProductTest < ActiveSupport::TestCase

  #fixtures :products 

  test "correct product attributes" do 
    p = Product.new
    assert p.invalid?
    assert p.errors[:title].any?
    assert p.errors[:description].any?
    assert p.errors[:price].any?
    assert p.errors[:image].any?
  end


  test "product price must be 0.01 or higher" do
    p = Product.new(
      title: "test", description: "test")
    p.image.attach(
      io: File.open("test/fixtures/files/lorem.jpg"), 
      filename: "lorem.jpg",
      content_type: "image/jpeg")

    p.price = -1; assert p.invalid?
    assert_equal ["must be greater than or equal to 0.01"], p.errors[:price]
    p.price = 0; assert p.invalid?
    assert_equal ["must be greater than or equal to 0.01"], p.errors[:price]
    p.price = 1; assert p.valid?
  end


  test "product image filetype must be gif, jpeg or png" do 
    p = Product.new(
      title: "test", description: "test", price: 1.0)

    p.image.attach(
      io: File.open("test/fixtures/files/lorem.jpg"), 
      filename: "lorem.jpg",
      content_type: "image/jpeg")
    assert p.valid?, "image/jpeg must be valid"

    p = Product.new(
      title: "test", description: "test", price: 1.0)

    p.image.attach(
      io: File.open("test/fixtures/files/lorem.svg"), 
      filename: "lorem.jpg",
      content_type: "image/svg+xml")
    assert_not p.valid?, "image/svg+xml must be invalid"
  end


  test "product is not valid without a unique title" do 
    p = Product.new(title: products(:pragprog).title, description: "test", price: 1.0)
    p.image.attach(
      io: File.open("test/fixtures/files/lorem.jpg"),
      filename: "lorem.jpg",
      content_type: "image/jpeg")
    assert product.invalid?
    assert_equal ["has already been taken"], p.errors[:title]
  end

end
