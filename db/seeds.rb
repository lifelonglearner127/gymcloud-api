# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bar = ProgressBar.create(
  title: 'Seeds',
  total: 2
)

bar.log('AgreementCategory')
Services::Seed::AgreementCategory.!
bar.increment

bar.log('GlobalProperty')
Services::Seed::GlobalProperty.!
bar.increment

bar.finish
