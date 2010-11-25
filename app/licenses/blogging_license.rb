puts "BloggingLicense loaded"
puts "License::Base is defined" if defined? License::Base

class BloggingLicense < License::Base
  def initialize name
    super
  end
  
  def enforce!
    can(:read, Blog)
    can(:create, Post)
    owns(user, Post)
  end
end

puts "BloggingLicense is defined" if defined? BloggingLicense