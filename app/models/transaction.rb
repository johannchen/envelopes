class Transaction < ActiveRecord::Base
  belongs_to :envelope, :account, :user
end
