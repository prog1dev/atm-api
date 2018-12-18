namespace :db do
  task seed: :environment do
    available_values = [1, 2, 5, 10, 25, 50]

    available_values.each do |value|
      Money.create!(value: value, count: 0)
    end
  end
end
