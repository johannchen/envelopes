class Account < ActiveRecord::Base
  has_many :transactions
  belongs_to :user

  validates_presence_of :name, :user
  validates_uniqueness_of :name, :scope => :user_id
end
