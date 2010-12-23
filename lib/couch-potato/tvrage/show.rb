module CouchPotato
  module TVRage
    class Show
      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'
              
      class << self
        def search(show_name)
          response = get('/myfeeds/search.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :show => show_name}).parsed_response['Results']['show']
          response.nil? ? [] : response.objectify
        end
        
        def show_info(show_id)
          response = get('/myfeeds/showinfo.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :sid => show_id}).parsed_response['Showinfo']
          response.nil? ? [] : response.objectify
        end        
      end
    end
  end
end