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
    description "Toyota Car Loan"
    amount 500
    account
    envelope
    user
  end
end
