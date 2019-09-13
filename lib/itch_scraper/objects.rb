require 'nokogiri'
require 'open-uri'
require 'pry'

include MenuModule

class ItchObj
   attr_accessor :inp
   attr_reader :title, :price, :author, :short_text, :platforms, :url
   @@all=[]

   def initialize(inp,basic_info_hash)
      @inp=inp
      @url=basic_info_hash[:url]
      @title=basic_info_hash[:title]
      @price=basic_info_hash[:price]
      @author=basic_info_hash[:author]
      @short_text=basic_info_hash[:short_text]
      @platforms=basic_info_hash[:platforms]
      self.class.all << self
   end
   
   #basic info is stored
   def obj_basic
      puts "#{title} #{price}"
      puts "by #{author}"
      puts short_text
      puts platforms
      menu_divider
   end

   def obj_basic_view
      puts "\nVIEWING:"
      obj_basic
   end

   def obj_detail
      puts url
      puts "\n"
      textparse
   end

   #detailed info is not stored
   def textparse
      doc=Nokogiri::HTML(open(@url))
      #binding.pry
      doc.css("div.formatted_description.user_formatted *").each do |a|
         parsing(a)
      end
   end
   
   def parsing(a)
      if ["h1","h2","h3","h4","h5"].include?(a.name)
         puts "\n#{a.text}"
      elsif a.name=="li"
         puts "> #{a.text}"
      elsif a.name=="br"
         puts ""
      else
         puts a.text.lstrip unless ["strong","em","a","ul","img","figure"].include?(a.name)
      end
   end

   #access @@all to see previously-viewed items
   def self.all
      @@all
   end

   def self.all_view
      puts "\nPREVIOUSLY VIEWED:\n"
      menu_divider
      self.all.each_with_index do |i,index|
         puts "#{index+1}. #{i.url}"
         i.obj_basic
      end
   end

end