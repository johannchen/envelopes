class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create

  has_many :envelops 
  has_many :accounts
  has_many :transactions
end