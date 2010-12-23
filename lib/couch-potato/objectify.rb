require 'ostruct'

module Objectify
  def objectify(object = self)
    return case object
    when Hash
      obj = {}
      object.each { |k,v| obj[k.downcase] = objectify(v) }
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