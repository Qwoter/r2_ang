require 'spec_helper'

describe Table do
  it "has a valid factory" do
    expect(build(:table)).to be_valid
  end
  
  it "is invalid without number" do
    expect(build(:table, number: nil)).to_not be_valid
  end

  it "number must be uniq" do
    create(:table)

    expect(build(:table)).to_not be_valid
  end
end
