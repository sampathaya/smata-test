Vertical.destroy_all
Category.destroy_all
Course.destroy_all
User.destroy_all

user = User.create(username: 'sampath', password: 'abcd1234')

puts "-- Startvertical records seeding --"
path = File.join(File.dirname(__FILE__), '/seeds/verticals.json')
records = JSON.parse(File.read(path))
records.each do |record|
  user.verticals.create!({name: record.dig('Name')}) if user
end

path = File.join(File.dirname(__FILE__), '/seeds/categories.json')
records = JSON.parse(File.read(path))
records.each do |record|
  vertical = Vertical.find_by(name: record.dig('Verticals'))
  vertical.categories.create({name: record.dig('Name'), state: record.dig('State')}) if vertical
end

path = File.join(File.dirname(__FILE__), '/seeds/courses.json')
records = JSON.parse(File.read(path))
records.each do |record|
  category = Category.find_by(name: record.dig('Categories'))
  category.courses.create({name: record.dig('Name'), author: record.dig('Author'), state: record.dig('Author')}) if category
end
