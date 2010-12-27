require 'spec_helper'

module GoggleBox::TVRage
  describe Show do
    before do
      @show_id = 25745
    end
    
    describe "a show with a real ID" do
      before do
        xml = File.read("spec/xml/tvrage/show/better_with_you.xml")
        FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/showinfo.php?sid=#{@show_id}", :body => xml)
      end

      subject { Show.new(@show_id) }      
      { 
        :showid => "25745",
        :showname => "Better With You",
        :showlink => "http://www.tvrage.com/Better_Together",
        :seasons => "1",
        :image => "http://images.tvrage.com/shows/26/25745.jpg",
        :started => "2010",
        :startdate => "Sep/22/2010",
        :ended => nil,
        :origin_country => "US",
        :status => "New Series",
        :classification => "Scripted",
        :summary => "Which kind of love is better, the slow and steady kind that grows over time or the truly, madly deeply kind that happens in a flash? Two couples, from two different generations, have very different outlooks on love. But together, they discover that when it comes to relationships, everyone has to find their own way. Ben and Maddie followed every rule, except for getting married. After nine years together, they're totally committed to each other and they don't need a stupid piece of paper to prove it, thank you very much. At least until Maddie's little sister Mia gets engaged. Mia and Casey are completely different from Ben and Maddie. Young and impulsive, Mia and Casey live in the moment which might have something to do with how Mia and Casey ended up both pregnant and engaged after only two months of dating. At first, Ben and Maddie are shocked... and maybe even a little jealous. Should they have gotten married at some point? They're even more jealous when Maddie and Mia's notoriously high-maintenance, meddling parents, the Putneys, welcome their new son-in-law with open arms. Maddie and Ben have to ask themselves... is their slow, cautious love as strong as Mia and Casey's untamed version? As Ben and Maddie welcome Casey into their lives and help guide him through the minefields of Maddie and Mia's eccentric family little by little both of these couples discover that married or not, it's the togetherness that counts. From creator Shana Goldberg-Meehan (Friends, Mad About You) comes a fresh, funny look at couplehood. No two relationships are quite alike. That's part of what makes them so great.",
        :genres => OpenStruct.new(:genre => ["Comedy", "Family"]),
        :runtime => "30",
        :network => "ABC",
        :airtime => "20:30",
        :airday => "Wednesday",
        :timezone => "GMT-5 -DST",
        :akas => OpenStruct.new(:aka => ["Better Together", "Leapfrog", "That Couple"])
      }.each do |attr, value|
        it "Show should respond to #{attr}" do
          subject.send(attr).should == value
        end
      end

      describe "lazy loading of show and episode information together" do
        before do
          xml = File.read("spec/xml/tvrage/show/better_with_you_full_one_season.xml")
          FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/full_show_info.php?sid=#{@show_id}", :body => xml)
        end

        subject { Show.new(@show_id, :lazy => true) }  
        { 
          :showid => "25745",
          :name => "Better With You",
          :showlink => "http://tvrage.com/Better_With_You",
          :image => "http://images.tvrage.com/shows/26/25745.jpg",
          :started => "Sep/22/2010",
          :ended => nil,
          :origin_country => "US",
          :status => "New Series",
          :classification => "Scripted",
          :genres => OpenStruct.new(:genre => ["Comedy", "Family"]),
          :runtime => "30",
          :network => "ABC",
          :airtime => "20:30",
          :airday => "Wednesday",
          :timezone => "GMT-5 -DST",
          :akas => OpenStruct.new(:aka => ["Better Together", "Leapfrog", "That Couple"])
        }.each do |attr, value|
          it "Show should respond to #{attr}" do
            subject.send(attr).should == value
          end
        end
        
        it "Show should respond to episodelist" do
          subject.episodelist.class.should be(OpenStruct)
        end

        describe "Shows with just one season" do
          it "Episodelist should have an OpenStruct of a season if just one" do
            subject.episodelist.season.class.should be(OpenStruct)
          end

          it "Season should have an array of episodes if more than one" do
            subject.episodelist.season.episode.class.should be(Array)
          end
          
          it "Season should more than one episode to constitute an array" do
            subject.episodelist.season.episode.size.should have_at_least(2).items
          end
        end

        describe "Shows with more than one season" do
          before do
            xml = File.read("spec/xml/tvrage/show/better_with_you_empty_second.xml")
            FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/full_show_info.php?sid=#{@show_id}", :body => xml)
          end
          
          it "Episodelist should have an Array of seasons" do
            subject.episodelist.season.class.should be(Array)
          end

          it "Array of Seasons shouldn't be equal to one" do
            subject.episodelist.season.size.should have_at_least(2).items
          end
          
          it "Episode should have an OpenStruct if only one episode" do
            subject.episodelist.season[1].episode.class.should be(OpenStruct)
          end
          
        end   
      end
    end

    describe "an invalid show id" do
      before do
        xml = File.read("spec/xml/tvrage/show/no_results.xml")
        FakeWeb.register_uri(:get, "http://services.tvrage.com/feeds/showinfo.php?sid=#{@show_id}", :body => xml)
      end

      subject { Show.new(@show_id) }  
      it "should be an array" do
        subject.class.should be(Array)
      end
    
      it "should be an empty array" do
        subject.should be_empty
      end
    end

  end
end
