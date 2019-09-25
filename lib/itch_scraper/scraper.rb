include MenuModule

class Scraper
   attr_accessor :doc, :display_elements_array

   ##############  START OF CLI CLASS  ##############

   def initialize
      @doc=Nokogiri::HTML(open('https://itch.io/games'))
   end

   def menu_names_category
      doc.css("div.classification_picker div.filter_options a").collect{|a|a.text}
   end

   def menu_names_sort
      doc.css("ul.sorts li").collect{|a|a.text}
   end

   def url_adds_category
      doc.css("div.classification_picker div.filter_options a").collect{|a|a.attr("href")}
   end

   ##############  DISPLAY ELEMENTS  ##############

   def scrape_and_display_basics(url,page_range_1,page_range_2)
      @doc=Nokogiri::HTML(open(url))
      @display_elements_array=[]
      doc.css("div.game_cell.has_cover div.game_cell_data")[page_range_1..page_range_2].each {|a|display_elements_array.push(a)}
      
      display_elements_array.each_with_index do |a,index|
         menu_divider
         print "#{index+1}. " + "#{title(a)} ".colorize(:yellow)
         puts price(a)
         puts "   by #{author(a)}"
         puts "   #{short_text(a)}"
         puts "   #{platforms(a)}"
         print "\n\n"
      end
   end

   ##############  SCRAPING FOR OBJ MAKING  ##############

   def obj_scrape_and_hash(inp)
      this_elem=@display_elements_array[inp-1]
   
      basic_info_hash={
         url: url(this_elem),
         title: title(this_elem),
         price: price(this_elem),
         author: author(this_elem),
         short_text: short_text(this_elem),
         platforms: platforms(this_elem)
      }
   end

   ##############  METHODS FOR PARAMETERS  ##############

   def title(a)
      a.children.css(".title").text
   end

   def price(a)
      if a.children.css("div.price_value").text==""
         "(free+)"
      else
         "#{a.children.css("div.price_value").text}+"
      end
   end

   def author(a)
      a.children.css(".game_author").text
   end

   def short_text(a)
      a.children.css(".game_text").text
   end

   def platforms(a)
      a.children.css(".game_platform span").map{|i|"(#{i.attr("title")[13..-1]})" unless i.attr("title")==nil}.join(" ")
   end

   def url(a)
      a.css("a.game_link").attr("href").value
   end

   ##############  TEXTPARSE FOR OBJ DETAILED VIEW  ##############
   
   def self.textparse(url)
      doc=Nokogiri::HTML(open(url))
      doc.css("div.formatted_description.user_formatted *").each do |a|
         self.parsing_rules(a)
      end
   end
   
   def self.parsing_rules(a)
      if ["h1","h2","h3","h4","h5"].include?(a.name)
         puts "\n#{a.text}"
      elsif a.name=="li"
         puts "> #{a.text}".colorize(:cyan)
      elsif a.name=="br"
         puts ""
      else
         puts a.text.lstrip.colorize(:cyan) unless ["strong","em","a","ul","img","figure"].include?(a.name)
      end
   end

end