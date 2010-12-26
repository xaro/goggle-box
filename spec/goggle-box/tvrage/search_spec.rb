require 'spec_helper'

module GoggleBox::TVRage
  describe Search do
    before do
      @show_name = "Better With You"
      @key = "d61mzsd8LETGxD0CAL7e"
    end
    
    describe "a successful search" do
      before do
        xml = File.read("spec/xml/tvrage/search/better_with_you.xml")
        FakeWeb.register_uri(:get, "http://services.tvrage.com/myfeeds/search.php?key=#{@key}&show=#{URI.escape(@show_name)}", :body => xml)
      end
      
      subject { Search.new(@show_name) }
      it "Resultset should be an array" do
        subject.class.should be(Array)
      end

      it "Resultset should not be an empty array" do
        subject.should have_at_least(1).items
      end
      
      it "Resultset should contain openstructs" do
        subject.first.class.should be(OpenStruct)
      end
      
      {
        :showid => "25745",
        :name => "Better With You",
        :link => "http://www.tvrage.com/Better_Together",
        :country => "US",
        :started => "2010",
        :ended => "0",
        :seasons => "1",
        :status => "New Series",
        :classification => "Scripted",
        :genres => OpenStruct.new(:genre => ["Comedy", "Family"])
      }.each do |attr, value|
        it "should respond to #{attr}" do
          subject.first.send(attr).should == value
        end
      end 
    end
    
    describe "an unsuccessful search" do
      before do
        xml = File.read("spec/xml/tvrage/search/no_results.xml")
        FakeWeb.register_uri(:get, "http://services.tvrage.com/myfeeds/search.php?key=#{@key}&show=#{URI.escape(@show_name)}", :body => xml)
      end
 
      subject { Search.new(@show_name) }  
      it "should be an array" do
        subject.class.should be(Array)
      end
    
      it "should be an empty array" do
        subject.should be_empty
      end
    end
  
  end
end