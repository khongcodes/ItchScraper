include MenuModule


class CLI
   attr_accessor :user_in, :nest_nav, :nn1_current_category, :nn2_current_sort, :url_str, :current_page_ind, :scraper
   
   scrape=Scraper.new
   
   #menu_names: contains titles of menus. Iteration allows for flexibility in the event that more menus are added
   #menu_names[1]=["Games","Tools","Game assets","Comics","Books","Physical games","Soundtracks","Game mods","Everything else"]
   #menu_names[2]=["Popular","New & Popular", "Top sellers","Top rated","Most Recent"]
   @@menu_names=[["Root"],scrape.menu_names_category,scrape.menu_names_sort]

   #url_arr: contains url modifications for menus.
   #url_arr: [NOTE] Sort-method url modifications not yet loaded-depending on which URL you are on, one of them is inaccessible so they are hard-coded for now.
   #url_adds[0]=["/games","/tools","/game-assets","/comics","/books","/physical-games","/soundtracks","/game-mods","/misc"]
   @@url_adds=[scrape.url_adds_category,["","/new-and-popular","/top-sellers","/top-rated","/newest"]]
   
   #page_arr: contains range values for "pages" in list menus.
   #page_arr: [NOTE] Itch.io has infinite scrolling in its menus, but Nokogiri shows that there are only 30 elements in its tables, so 3 pages of 10 are implemented here
   @@page_arr=[[0,9],[10,19],[20,29]]
   
   #setup nest_nav, nn1_current_category, user_in, url
   def initialize
      
      #nest_nav: contains value for current-view level of nested-menu navigation
      #nn1_current_category: stores value as index of menu_names[1] for most-recently-accessed lvl2 menu. This is for the purpose of going backwards/upwards
      #nn2_current_sort: stores value as index of menu_names[2] for most-recently-accessed lvl3 menu. This is for the purpose of going backwards/upwards
      #user_in: class variable so that it can be accessible through any method. Set to 1 because show_menu takes in inp-1 for its display - so display "root" at menu_names[0][inp-1]
      #current_page_ind: stores current-page value in lvl3 menus as index of page_arr
      @nest_nav=0
      @nn1_current_category=0
      @nn2_current_sort=0
      @user_in=1
      @current_page_ind=0
      @scraper=Scraper.new

      url_reset
   end

   #url_reset: reset the url to be ready for concatenation into different menu URLs
   def url_reset
      @url_str='https://itch.io'
   end

   def run
      welcome
      #keep menu looping while input != 'q'
      #user_in is set on initialize to 1 => show lvl1(Root) menu
      while @user_in!='q' do
         show_menu(@user_in)
      end
   end

   def welcome
      puts "Welcome to ItchScraper!"
   end

   #menu control
   def show_menu(inp)
      if @nest_nav==0||@nest_nav==1
         #if nest_nav is 1, store the name of the menu by accessing menu_names
         @nn1_current_category=@@menu_names[1][inp-1] if nest_nav==1
         #display text for lvl2 menu OR root
         puts "\n___#{@@menu_names[@nest_nav][inp-1]} Menu___".colorize(:light_red)
         menu_info
         @@menu_names[@nest_nav+1].each_with_index{|item,index|puts "#{index+1}." + " #{item}".colorize(:light_yellow)}
         puts "\n"
      elsif @nest_nav==2
         #everytime a lvl3 menu is accessed:
         #> store the name of the menu by accessing menu_names
         #> refresh url and reset it based on stored current-menu-info         
         @nn2_current_sort=@@menu_names[2][inp-1]
         url_reset
         @url_str.concat(@@url_adds[0][@@menu_names[1].index(@nn1_current_category)],@@url_adds[1][@@menu_names[2].index(@nn2_current_sort)])
         display_sorted_elements(@user_in)
      elsif @nest_nav==3
         display_object(@user_in)
      elsif @nest_nav==4
         previously_viewed_menu
      end
      check_input
   end

   #parse input based on nest_nav and checks if valid
   #at nest_nav=0, accept: 'q', int
   #at nest_nav=1, accept: 'q', int, 'b'
   #at nest_nav=2, accept: 'q', int, 'b', 'n', 'p'
   #at nest_nav=3, accept: 'q', 'b'
   #always accept 'v' for previously viewed items
   def check_input
      @user_in=gets.chomp
      if @user_in=='q'
         #exit program
         puts "\n"
         exit
      elsif @user_in=='b'&&@nest_nav>0
         #go up one level using menu_names, based on current nest_nav
         @nest_nav-=1
         @current_page_ind=0 if nest_nav<2
         show_menu(@@menu_names[2].index(@nn2_current_sort)+1) if nest_nav==2
         show_menu(@@menu_names[1].index(@nn1_current_category)+1) if nest_nav==1
      elsif @user_in=='n'&&@nest_nav==2
         #PAGE CONTROL: display next 10
         if @current_page_ind+1<3
            @current_page_ind+=1
            show_menu(@@menu_names[2].index(@nn2_current_sort)+1)
         else
            puts "Page cannot go higher than 3!"
            check_input
         end
      elsif @user_in=='p'&&@nest_nav==2
         #PAGE CONTROL: display prev 10
         if @current_page_ind+1>1
            @current_page_ind-=1
            show_menu(@@menu_names[2].index(@nn2_current_sort)+1)
         else
            puts "Page cannot go lower than 1!"
            check_input
         end
      elsif @user_in=="v"
         @nest_nav=4
      elsif @user_in=='w'
         @user_in=rand(1..10)
         @nest_nav+=1
      elsif @user_in.to_i<=0 || @user_in.to_i>10
         invalid_command
      else
         #if user_in is a valid integer, nesting level should be incremented by 1
         @nest_nav+=1
      end
      #pass along the input string, converted to integer
      @user_in=@user_in.to_i
   end

   def invalid_command
      puts "\nPlease enter a valid command."
      menu_info
      check_input
   end

   #nest_nav=2
   #displays list of objects of selected category via selected sort method
   #does NOT store data into objects in order to reduce the number of objects this program creates
   #instead Scraper reads the appropriate elements from the table of cells URL, referencing current_page index and stores them as temporary values into display_elements_array
   def display_sorted_elements(sort)
      #display menu titles
      puts "\n___ #{@nn1_current_category} : #{@nn2_current_sort} : page #{@current_page_ind+1} ___".colorize(:light_red) #[2][inp-1]
      puts @url_str
      menu_info
      scraper.scrape_and_display_basics(@url_str,@@page_arr[@current_page_ind][0],@@page_arr[@current_page_ind][1])
      menu_info
   end

   #nest_nav=3
   #zoom in on specific object
   #object of ItchObj created, values stored HERE
   def display_object(inp)
      basic_info_hash=scraper.obj_scrape_and_hash(inp)
      #find or create by name/author - don't make 2 copies of the same item
      this_obj=ItchObj.all.detect{|a|a.title==basic_info_hash[:title]&&a.author==basic_info_hash[:author]}||ItchObj.new(inp,basic_info_hash)
      this_obj.obj_basic_view
      this_obj.obj_detail
      menu_info
   end

   #nest_nav=4
   #too tired to work nest_nav into this, sorry - no 'back' option, only detail-view, quit, and root
   def previously_viewed_menu
      ItchObj.all_view
      puts "\nSelect an item by number to view it again, or type 'r' to return to root, or type 'q' to quit."
      inp=gets.chomp
      if inp=='q'
         puts "\n"
         exit
      elsif inp=='r'
         initialize
         run
      elsif inp.to_i<=0 || inp.to_i>ItchObj.all_view.length
         invalid_command
      else
         this_obj=ItchObj.all[inp.to_i-1]
         this_obj.obj_basic_view
         this_obj.obj_detail
         previously_viewed_menu
      end
   end

end
