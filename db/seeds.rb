# db/seeds.rb

Product.delete_all

puts "hello"

p = Product.create(
    title: "7nm 8metal lowpower CMOS 300nm wafer",
    description:
        %(
        7nm lithography<br>
        8 metal layers<br>
        low power transistor targets<br>
        std CMOS<br>
        300nm wafer
        ),
    price: 3500.00)

p.image.attach(
    io: File.open(
        Rails.root.join('db','images','silicon-wafer-1-4083097415.jpg')), 
    filename: 'silicon-wafer-1-4083097415.jpg'
)
p.save!

def attach_default_image_to (p)
    p.image.attach(
        io: File.open(
            Rails.root.join('db','images','silicon-wafer-1-4083097415.jpg')),
        filename: 'silicon-wafer-1-4083097415.jpg'
        )
end

seedprodnames = %w{ 7nm-8m-cmoslp-300nm 
                    7nm-8m-cmoshp-300nm 
                    7nm-8m-cmos-300nm }

puts seedprodnames

seedprodnames.each do |name|
    p = Product.create(
        title: name, description: "temp", price: 1500.00)
    attach_default_image_to p
    p.save!
end
