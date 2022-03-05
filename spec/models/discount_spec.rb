require 'rails_helper'

describe Discount do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_presence_of :percentage }

  end
  describe "relationships" do
    it { should belong_to :merchant }
  end
end
