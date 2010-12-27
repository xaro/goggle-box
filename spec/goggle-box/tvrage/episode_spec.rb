require 'spec_helper'

module GoggleBox::TVRage
  describe Episode do
    before do
      @show_id = 25745
      @episode = '1x01'
      xml = File.read("spec/xml/tvrage/episode/single_episode.xml")
      FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/episodeinfo.php?sid=#{@show_id}&ep=#{@episode}", :body => xml)
    end
    
    describe "individual episode information" do
      subject { Episode.information(@show_id, @episode) }
      { 
        :number       => "01x01",
        :title        => "Pilot",
        :airdate      => "2010-09-22",
        :url          => "http://www.tvrage.com/Better_Together/episodes/1064933988"
      }.each do |attr, value|
        it "Episode should respond to #{attr}" do
          subject.send(attr).should == value
        end
      end
    end

    describe "next episode information" do
      subject { Episode.next_episode(@show_id, '1x01') }
      { 
        :number       => "01x11",
        :title        => "Better with Skinny Jeans",
        :airdate      => "2011-01-05",
        :airtime      => ["2011-01-05T20:30:00-5:00", "1294273800"] 
      }.each do |attr, value|
        it "Episode should respond to #{attr}" do
          subject.send(attr).should == value
        end
      end
    end

    describe "latest episode information" do
      subject { Episode.latest_episode(@show_id, '1x01') }
      { 
        :number       => "01x10",
        :title        => "Better with Christmas Crap",
        :airdate      => "2010-12-08"
      }.each do |attr, value|
        it "Episode should respond to #{attr}" do
          subject.send(attr).should == value
        end
      end
    end

  end
end
    