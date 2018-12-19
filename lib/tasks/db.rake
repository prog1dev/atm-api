namespace :db do
  task seed: :environment do
    denominations = [1, 2, 5, 10, 25, 50]

    denominations.each do |denomination|
      Money.create!(denomination: denomination, count: 0)
    end
  end
end
