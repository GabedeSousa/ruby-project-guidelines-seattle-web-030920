# for some reason the data I created before making the methods are causing an error
#  the methods only work for the data created with the app.
class Swim 

    def self.run
      puts "WELCOME TO iSwim".blue
    

      while true

        puts "\nType 'help' to see the list of commands. Type 'quit' to exit.".magenta
        print "Enter command: ".cyan
        input = gets.chomp

        break if input == "quit" || input == "exit"
        case input
        when "help"
          Swim.help
        when "list practices"
          Swim.list_practices
        when "list viewers"
          Swim.list_viewers
        when "list countries"
          Swim.list_countries
        when "list coaches"
            Swim.list_coaches
        when "create practice"
            Swim.create_practice
        when "create viewer"
            Swim.create_viewer
        when "create rating"
            Swim.create_rating 
        when "practice"
          Swim.practice
        # when "viewer"
        #   Swim.viewer
        when "update coach"
          Swim.update_coach
        when "delete practice"
          Swim.delete_practice
        when "self help"
            puts "Thank you for choosing iSwim <3" 
            puts "\n"
            10.times do
              puts "^o^".red * 10
            end
        else
            puts "\n  invalid command, type 'help' to see the list of available commands"
        end
      end
    end


    def self.help
      puts "Help".bold
      puts "  help\t\t\t:show this help menu".green
      puts "List".bold
      puts "  list practices\t:list all practice titles".green
      puts "  list viewers\t\t:list names of all viewers".green
      puts "  list countries\t:list names of all countries practices".green
      puts "  list coaches\t\t:list names of all coaches".green
      puts "Create".bold
      puts "  create practice\t:creates a new practice".green
      puts "  create viewer\t\t: creates e new viewer".green
      puts "  create rating\t\t: creates a new rating".green
      puts "Update".bold
      puts "  update coach\t\t:updates a practice coach".green
      puts "Delete".bold  
      puts "  delete practice\t: delete a practice".green
      puts "All Data".bold
      puts "  practice\t\t:go to menu for practice data".green
      # puts "  viewer\t\t:go to menu for viewer data" # bug
      puts "Quit".bold
      puts "  quit\t\t\t:quit the app".green
      puts "  exit\t\t\t:alias for quit".green
    end


   def self.list_practices #debug
      Practice.all.each_with_index do |view,a|
      puts (a+1).to_s + ".\t#{view.practice}"
      end
    end

    def self.update_coach
      puts "enter the practice number you would like to update"
      new_practice = gets.chomp
      practice = Practice.find_by(id: new_practice)
      puts "enter a new coach name"
      new_coach = gets.chomp
      practice.update(coach: new_coach)
    end

    def self.delete
      Practice.destroy_all
    end

    def self.create_practice 
      #this is trick because practice involves a bunch of
      # words, numbers and symbols
      # so when I create a new practice it shows invalid command
      #but works
      puts "add a title for your practice: 'Sprint' 'Mid Distance' or 'Distance'"
      title = gets.chomp

      puts "add a coach for your practice"
      coach = gets.chomp

      puts "add your country"
      country = gets.chomp

      puts "add your practice"
      practice = gets.chomp

      Practice.create(title: title, coach: coach, country: country, practice: practice)


    end

    def self.create_viewer 
  
      puts "Add your name to create a new Swim Practice  Viewer"
      name = gets.chomp

      puts "Please add your country"
      country = gets.chomp

      Viewer.create(name: name, country: country)


    end

    def self.create_rating 
  
      puts "Add a rating to your swim practice"
      rating = gets.chomp

      puts "Please choose your practice"
      practice_id = gets.chomp

      puts "Please enter your viewer id"
      viewer_id = gets.chomp

      Rating.create(rating: rating, practice_id: practice_id, viewer_id: viewer_id)


    end

    def self.delete_practice
      puts "enter the practice number you would like to delete"
      new_practice = gets.chomp
      practice = Practice.find_by(id: new_practice)
      practice.destroy
    end

    

   

    def self.list_viewers
        Viewer.all.each_with_index do |view,a| 
            puts (a+1).to_s + ".\t#{view.name}" 
        end
    end

    def self.list_coaches
        Practice.all.each_with_index do |view,a|
            puts (a+1).to_s + ".\t#{view.coach}"
        end
    end

    def self.submenu_help(menu)
        puts "Help".bold
        puts "  help\t\t\t:show help menu".green
        puts "List".bold
        puts "  list\t\t\t:list all #{menu}s".green
        puts "Navigation".bold
        puts "  exit\t\t\t:exit to main menu".green
        puts "  main\t\t\t:alias for exit".green
    end

    def self.list_countries
        Practice.countries.each do |country| 
          puts country 
        end
    end

    def self.show_data(practice) #can't find top 3 why???
      puts "  title:\t\t#{practice.title}"
      puts "  practice: \t\t#{practice.practice}"
      puts "  country:\t\t#{practice.country}"
      puts "  total viewers:\t#{practice.num_ratings}"
      puts "  average rating:\t#{practice.average_rating}"
    end

    def self.coach_list(practice) ### not working
        
        loop do
          print "List the Coach for this practice? (y/n): ".magenta
          yn = gets.chomp
    
          case yn
          when 'y'
            puts practice.coach
            break
          when 'n'
            break
         end
       end
    end

    def self.list_practice_viewers(practice)
        loop do
          print "List viewers of this practice? (y/n): ".magenta
          yn = gets.chomp
    
          case yn
          when 'y'
            loop do
              print "List all viewers? (all): ".magenta

              all_viewers = gets.chomp
              case all_viewers
              when "all"
                practice.viewers.each do |a| 
                    puts a.name + ",  " + a.country 
                end
                break
            end
        end
        puts "\n"
     when 'n'
        break
     end
    end
  end

   def self.viewer_data(viewer)
    
     puts "  name:\t\t#{viewer.name}"
     puts "  country:\t#{viewer.country}"
     puts "  top practices:"
     if viewer.top_three.empty?
       puts "\tno practices rated".upcase
       else
       puts "\trating\tpractices".upcase
       viewer.top_three.each { |r| puts "\t#{r.rating}\t#{r.practice.title}" }
      end
    end

   def self.list_viewed_practices?(viewer)
    loop do
      print "List all viewed practices? (y/n): ".magenta
      yn = gets.chomp

      case yn
      when 'y'
        viewer.practices.each do |s| 
          puts s.title 
        end
        break
      when 'n'
        break
      end
    end
   end

   def self.list_favorite_practices?(viewer)
    loop do
      print "List favorite practices? (y/n): ".magenta
      yn = gets.chomp

      case yn
      when 'y'
        loop do
          print "type '1' to see your favorite practice " 
          practice_number = gets.chomp.to_i
            practice = viewer.top_three[practice_number-1].practice 
            Swim.show_data(practice) 
            Swim.coach_list(practice)
            puts "\n"
            break
           
        end
      when 'n'
        break
      end
     end
    end
  

   def self.practice
    loop do
      puts "\nType 'list' to list all practices, or 'exit' to return to main menu".magenta
      print "Enter list: "

      input = gets.chomp

      break if input == "exit" || input == "main"

      if input == "list" #needs debug
        Swim.list_practices
      elsif input == "help"
        Swim.submenu_help("practice")
      else
        begin
          id = input.to_i

          
        
          id = Practice.all[id-1]
          Swim.show_data(practice)
          puts "\n"
          Swim.coach_list?(practice)
          Swim.list_practice_viewers(practice)
        end
      end
    end
  end
        
         
      
  

  


   def self.viewer
    loop do
      puts "\nType 'list' to list viewers, type viewer ID number or type 'help' for help".magenta
      print "Enter list: "

      input = gets.chomp

      break if input == "exit" || input == "main"

      if input == "list"
        Swim.list_viewers
      else input == "help"
        Swim.submenu_help("viewer")

        begin
          id = input.to_i
          
          viewer = Viewer.all[id-1] 
          Swim.viewer_data(viewer)
          puts "\n"
          Swim.list_viewed_practices?(viewer)
          Swim.list_favorite_practices?(viewer)
        end
      end
    end
  end
end
        
        




