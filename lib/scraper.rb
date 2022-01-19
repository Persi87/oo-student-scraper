require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = URI.open(index_url)
    doc = Nokogiri::HTML(html)

    student_index_array = []

      doc.css(".student-card a").each do |student|
        # student_name = student.children.children.children[1].text
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.attribute('href').value # gone through the returned array rather than the css here.  Worked way through the array and hashes
        # student_url = student.css("a")[0].attributes["href"].value #use the "students.css" array output to help locate the needed code, and work through the levels
        student_index_array << {name: student_name, location: student_location, profile_url: student_url}
        # binding.pry
      end

      student_index_array

  end

  def self.scrape_profile_page(profile_url)
    html = URI.open(profile_url)
    doc = Nokogiri::HTML(html)

    profile = {}

    quote = doc.css(".profile-quote").text
    profile[:profile_quote] = quote

    bio = doc.css(".description-holder p").text
    profile[:bio] = bio

    profile_links = doc.css(".social-icon-container a").collect {|link_array| link_array.attributes["href"].value}
    
    profile_links.each do |link|
      if link.include?("twitter.com")
        profile[:twitter] = link
      elsif link.include?("linkedin.com")
        profile[:linkedin] = link
      elsif link.include?("github.com")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end

    profile
    
  end

end

