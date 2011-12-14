class Transaction < ActiveRecord::Base
  belongs_to :envelop, :account, :user
end
