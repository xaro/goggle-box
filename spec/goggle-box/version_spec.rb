require 'spec_helper'

describe GoggleBox do
  describe "versioning included in the gem" do
    it "should have a version" do 
      GoggleBox::VERSION.should_not be_blank
    end
    
    it "should match major, minor and patch" do
      version = GoggleBox::VERSION.split('.')      
      version.size.should == 3
    end
  end
end
