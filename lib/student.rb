class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)   # have a look at this coz I don't really understand it... "Mass Assignment"
    end
    @@all << self
  end

  def self.create_from_collection(students_array) #passing in - [{name: Simon, location: Streetly}, {another:, hash}] 
    students_array.each do |student_info|
         Student.new(student_info)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    end
    self.name
  end

  def self.all
    @@all
  end
end

