# frozen_string_literal: true

require 'faker'

Rails.logger.debug 'Создание категорий...'
if Category.none?
  %w[Авто Недвижимость Электроника].each do |name|
    Category.find_or_create_by!(name: name)
  end
end
categories = Category.all

Rails.logger.debug 'Создание пользователей...'
if User.count < 5
  (5 - User.count).times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      provider: 'github',
      uid: Faker::Number.unique.number(digits: 6).to_s
    )
  end
end
users = User.all

Rails.logger.debug 'Создание объявлений...'
image_paths = Rails.root.glob('test/fixtures/files/bulletin_*.jpg')
created_count = 0

while Bulletin.count < 20
  bulletin = Bulletin.new(
    title: Faker::Lorem.sentence(word_count: 3).truncate(50),
    description: Faker::Lorem.paragraph_by_chars(number: 500),
    user: users.sample,
    category: categories.sample,
    state: 'published'
  )

  image_file = File.open(image_paths[Bulletin.count % image_paths.size])
  bulletin.image.attach(
    io: image_file,
    filename: File.basename(image_file),
    content_type: 'image/jpeg'
  )

  if bulletin.save
    created_count += 1
  else
    Rails.logger.debug { "Ошибка при создании объявления: #{bulletin.errors.full_messages.join(', ')}" }
  end

  sleep 0.1
end

Rails.logger.debug { "Создано #{created_count} новых объявлений" }
Rails.logger.debug 'Готово!'
