# module GoggleBox
#   require 'httparty'
#   require 'goggle-box/objectify.rb'
#   require 'goggle-box/tvrage.rb'
# end

module GoggleBox
  require 'httparty'
  autoload :TVRage, 'goggle-box/tvrage.rb'
  
  class << self
    attr_accessor :adapter    
    def adapter
      @adapter ||= GoggleBox::TVRage      
    end
  end
end