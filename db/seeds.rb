100.times do
  Todo.create({
    title: Faker::Lorem.unique.paragraph(sentence_count: 1),
    description: Faker::Lorem.unique.paragraph(sentence_count: 3),
    complete: [true, false].sample
  })
end
