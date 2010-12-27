## GoggleBox
A simple and small Ruby Library for the TVRage API. ([here](http://services.tvrage.com/index.php?page=public))

### What is a GoggleBox?
'Goggle Box' is 'Cockney' (a dialect of British English) rhyming slang for television. Thanks to Caius for the name, which was briefly discussed in the #nwrug IRC channel.

### What does it do?
It allows you to search and retrieve Shows and Episodes from the TVRage API. Objects are returned as OpenStructs.

### Usage

#### Search
    >> shows = GoggleBox::TVRage::Show.search("Better With You")
    => [#<OpenStruct status="New Series", started="2010", classification="Scripted", country="US", ended="0", genres=#<OpenStruct genre=["Comedy", "Family"]>, link="http://www.tvrage.com/Better_Together", name="Better With You", showid="25745", seasons="1">..]
    
#### Show Information
    >> show = GoggleBox::TVRage::Show.new(shows.first.showid)
    => #<OpenStruct origin_country="US", runtime="30", startdate="Sep/22/2010", status="New Series", started="2010", timezone="GMT-5 -DST", showlink="http://tvrage.com/Better_Together", akas=#<OpenStruct aka=["Better Together", "Leapfrog", "That Couple"]>, classification="Scripted", airtime="20:30", showname="Better With You", ended=nil, network="ABC", genres=#<OpenStruct genre=["Comedy", "Family"]>, airday="Wednesday", showid="25745", seasons="1">
    
#### Lazy Loading (Includes Episode Listings)
    >> show = GoggleBox::TVRage::Show.new(shows.first.showid, :lazy => true)
    
    - If one season only
    >> show.episodelist.season => Only season or array of seasons
    >> show.episodelist.season.episode => Episodes in this season
    
    - If more than one season
    >> show.episodelist.season.first => First season
    >> show.episodelist.season.second => Second season etc
    >> show.episodelist.season.first.episode => Array of episodes in season etc
    
### What doesn't it do?
At the minute, it doesn't access the full functionality of the TVRage API. For example, it doesn't yet hook into the TVRage Scheduler or Countdown
as these are intended for a future release.

### Still todo
1) Finish off less important TVRage functionality (countdowns etc)
2) Implement mappings to override default schema of TVRage and other providers response
3) Plug in TheTVDB, IMDB etc
4) Tests could be better - they'll improve over time and change

### Thanks
Caius - For the name
hsume2 - I based the original tests on those from sofa.