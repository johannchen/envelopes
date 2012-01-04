require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  describe "Login User" do
    it "manages all his resources" do
      user = Factory(:user)
      ability = Ability.new(user)
      ability.should be_able_to(:manage, Envelope.new(:user => user))
    end
  end

  describe "Guest" do
    it "cannot manage any resources" do
      user = User.new
      ability = Ability.new(user)
      ability.should_not be_able_to(:manage, :all) 
    end
  end
end
