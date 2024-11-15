# db/seeds.rb

Product.delete_all

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
