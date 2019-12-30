User.destroy_all
Review.destroy_all

10.times do
    User.create name: Faker::Name.name
end

