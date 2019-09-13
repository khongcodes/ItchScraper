module MenuModule
   
   def menu_info      
      puts "\n"
      case @nest_nav
      when 1
         puts "Select a Category menu by number or type 'q' to quit- "
      when 2
         puts "Select a Sort method by number!"
         puts q_or_b.capitalize
      when 3
         puts "Select a Game by number to learn more! "
         case @current_page_ind
         when 0
            print "Type 'n' to see the next 10, "
         when 1
            print "Type 'p' to see the previous 10, type 'n' to see the next 10, "
         when 2
            print "Type 'p' to see the previous 10, "
         end
         puts q_or_b
      when 4
         puts v_or
         puts q_or_b.capitalize
      end
      puts "\n"
   end

   def q_or_b
      "type 'q' to quit, or type 'b' to go back- "
   end

   def v_or
      "Type 'v' to view previously-viewed items, "
   end

   def menu_divider
      puts "________________________________________________________________________"
   end
   
end