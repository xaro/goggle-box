module GoggleBox
  module TVRage
    class Show
      include HTTParty
      format :xml
      base_uri 'services.tvrage.com'
              
      class << self
        def search(show_name = nil)
          response = get('/feeds/search.php', :query => { :show => show_name }).parsed_response['Results']['show']
          response.nil? ? [] : response.objectify(self)
        end
        
        def new(show_id = nil, options = {})
          params = options[:lazy] ? { :file => 'full_show_info', :tag => 'Show' } : { :file => 'showinfo', :tag => 'Showinfo' }          
          response = get("/feeds/#{params[:file]}.php", :query => { :sid => show_id }).parsed_response["#{params[:tag]}"]
          response.nil? ? [] : response.objectify
        end        
      end
    end
  end
end