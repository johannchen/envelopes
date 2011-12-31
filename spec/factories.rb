FactoryGirl.define do
  factory :user do
    name "johann"
    email "johannchen@example.com"
    password "secret"
  end

  factory :envelope do
    name "Auto"
    budget 800
    monthly :true
    user
  end

  factory :account do
    name "BOA"
    user
  end

  factory :transaction do
    date Date.today
    name "Toyota"
    description "Car Loan"
    amount 500
    allocated false
    account
    envelope
    user
  end

  factory :envelope_with_transactions, :parent => :envelope do
    after_create do |envelope|
      FactoryGirl.create(:transaction, :envelope => envelope)
      FactoryGirl.create(:transaction, :amount => -400, :envelope => envelope)
      FactoryGirl.create(:transaction, :amount => -50, :envelope => envelope)
    end
  end
end
