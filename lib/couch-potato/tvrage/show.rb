module CouchPotato
  module TVRage
    class Show
      
      format :xml
      base_uri 'services.tvrage.com'
              
      class << self
        def search(show_name, shows = [])
          results = get('/myfeeds/search.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :show => 'How I Met Your Mother'})['Results']['show']
          results.each { |show| shows << Show.new(show) }
          shows
        end
        
        def show_info(show_id)
          show = get('/myfeeds/showinfo.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :sid => show_id})
          show['Showinfo']
        end
        # 
        #         def episode_listings(show_id)
        #           episodes = get('/myfeeds/episode_list.php', :query => {:key => 'd61mzsd8LETGxD0CAL7e', :sid => show_id})
        #           Season.objectify(episodes['Show']['Episodelist'])
        #         end
      end
      
      def initialize(show)
        klass = self.class
        map(show)
      end
      
      def method_missing(method, *args)
        return instance_variable_get("@#{method}")
        super
      end
      
    end
  end
end