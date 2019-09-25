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
      puts "#{title}".colorize(:yellow) + " #{price}"
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
      Scraper.textparse(@url)
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