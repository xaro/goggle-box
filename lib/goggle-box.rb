# module GoggleBox
#   require 'httparty'
#   require 'goggle-box/objectify.rb'
#   require 'goggle-box/tvrage.rb'
# end

module GoggleBox
  require 'httparty'
  require 'goggle-box/tvrage.rb'
  require 'goggle-box/thetvdb.rb'
  
  class << self
    attr_accessor :adapter    
    def adapter
      @adapter ||= GoggleBox::TVRage
      # require "goggle-box/thetvdb.rb"
    end
  end
end