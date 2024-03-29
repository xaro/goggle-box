module GoggleBox
  module TVRage
    class Episode
      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'
      
      class << self
        def listings_by_show(show_id = nil)
          response = get('/feeds/episode_list.php', :query => { :sid => show_id }).parsed_response['Show']['Episodelist']
          response.nil? ? [] : response.objectify
        end
        
        def information(show_id, episode)
          response = get('/feeds/episodeinfo.php', :query => { :sid => show_id, :ep => episode }).parsed_response['show']['episode']
          response.nil? ? [] : response.objectify
        end
        
        def next_episode(show_id, episode = '1x01')
          response = get('/feeds/episodeinfo.php', :query => { :sid => show_id, :ep => episode }).parsed_response['show']['nextepisode']
          response.nil? ? [] : response.objectify
        end
        
        def latest_episode(show_id, episode = '1x01')
          response = get('/feeds/episodeinfo.php', :query => { :sid => show_id, :ep => episode }).parsed_response['show']['latestepisode']
          response.nil? ? [] : response.objectify
        end
      end
    end
  end
end