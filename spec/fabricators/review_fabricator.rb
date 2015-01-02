Fabricator(:review) do
  body { Faker::Lorem.paragraph(3) }
  rating { (1..5).to_a.sample }
end