module GoggleBox
  module TVRage
    class Episode
      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'
      
      class << self
        def episode_list_by_season_for_show(show_id, episodes = [])
          response = get('/myfeeds/episode_list.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :sid => show_id}).parsed_response['Show']['Episodelist']
          response.objectify
        end
        
        def episode_info(show_id, episode)
          response = get('/myfeeds/episodeinfo.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :sid => show_id, :ep => episode}).parsed_response['show']
          response.objectify
        end
      end
    end
  end
end