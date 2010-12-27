require 'ostruct'

module Objectify
  
  DICTIONARY = {
    'season' => 'seasons',
    'episodelist' => 'episode_list',
    'episode' => 'episodes'
  }
  
  def swap_words(word)
    return word unless DICTIONARY[word]
    DICTIONARY[word]
  end
  
  def objectify(object = self)
    return case object
    when Hash
      obj = {}
      object.each { |k,v| obj[swap_words(k.downcase)] = objectify(v) }
      OpenStruct.new(obj)
    when Array
      object = object.clone
      object.map! { |i| objectify(i) }
    else
      object
    end
  end
end

class Hash
  include Objectify
end

class Array
  include Objectify
end