module GoggleBox
  module TVRage
    class Search
      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'
              
      class << self
        def new(show_name)
          response = get('/myfeeds/search.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :show => show_name}).parsed_response['Results']['show']
          response.nil? ? [] : response.objectify
        end        
      end
    end
  end
end