require 'spec_helper'

describe 'overview' do
  
  it "should work" do
    visit "/"
    page.should have_contect("Where is Ryan Bigg")
  end
  
end
