FactoryBot.define do
  factory :customer do
    first_name {Faker::TvShows::GameOfThrones.unique.character}
    last_name {Faker::TvShows::GameOfThrones.unique.character}
  end

  factory :invoice do
    status {[0,1,2].sample}
    merchant
    customer
  end

  factory :merchant do
    name {Faker::TvShows::GameOfThrones.unique.house}
    # discount
  end

  factory :item do
    name {Faker::TvShows::GameOfThrones.dragon}
    description {Faker::TvShows::GameOfThrones.quote}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
  end

  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    invoice
  end

  factory :invoice_item do
    status {[0,1,2].sample}
    merchant
    invoice
  end

  factory :discount do
    name {"#{(Faker::TvShows::GameOfThrones.unique.city)}'s Deal"}
    quantity_thresh { 10 }
    percentage { 20 }

    merchant
  end
end
