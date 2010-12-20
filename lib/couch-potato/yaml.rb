require 'ostruct'

class Hash
  def self.objectify(object)
    return case object
    when Hash
      object = object.clone
      object.each do |key, value|
        object[key.downcase] = objectify(value)
      end
      OpenStruct.new(object)
    when Array
      object = object.clone
      object.map! { |i| objectify(i) }
    else
      object
    end
  end
end