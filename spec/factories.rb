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
      Factory(:transaction, :envelope => envelope)
      Factory(:transaction, :amount => -400, :envelope => envelope)
      Factory(:transaction, :amount => -50, :envelope => envelope)
    end
  end

  factory :user_with_envelopes, :parent => :user do
    after_create do |user|
      Factory(:envelope, :monthly => true, :name => "Auto", :budget => 250, :user => user) 
      Factory(:envelope, :monthly => true, :name => "Home", :budget => 600, :user => user) 
      Factory(:envelope, :monthly => false, :name => "Tax", :budget => 1200, :user => user) 
      Factory(:envelope, :monthly => false, :name => "Birthday", :budget => 600, :user => user) 
    end
  end

  factory :user_with_envelopes_and_transactions, :parent => :user do
    after_create do |user|
      e1 = Factory(:envelope, :monthly => true, :name => "Auto", :budget => 250, :user => user) 
      e2 = Factory(:envelope, :monthly => true, :name => "Home", :budget => 400, :user => user) 
      e3 = Factory(:envelope, :monthly => false, :name => "Tax", :budget => 1200, :user => user) 
      e4 = Factory(:envelope, :monthly => false, :name => "Birthday", :budget => 600, :user => user) 
      Factory(:transaction, :amount => -100, :envelope => e1, :user => user)
      Factory(:transaction, :amount => -150, :envelope => e2, :user => user)
      Factory(:transaction, :amount => 400, :envelope => e1, :allocated => true, :user => user)
      Factory(:transaction, :amount => 3000, :envelope => nil, :user => user)
    end
  end

  factory :user_with_accounts_and_envelopes_and_transactions, :parent => :user do
    after_create do |user|
      e1 = Factory(:envelope, :monthly => true, :name => "Auto", :budget => 250, :user => user) 
      e2 = Factory(:envelope, :monthly => true, :name => "Home", :budget => 600, :user => user) 
      e3 = Factory(:envelope, :monthly => false, :name => "Tax", :budget => 1200, :user => user) 
      e4 = Factory(:envelope, :monthly => false, :name => "Birthday", :budget => 600, :user => user) 
      Factory(:transaction, :amount => -100, :envelope => e1, :user => user)
      Factory(:transaction, :amount => -200, :envelope => e2, :user => user)
      Factory(:account, :name => "BOA", :user => user)
      Factory(:account, :name => "Amazon", :user => user)
    end
  end
end
