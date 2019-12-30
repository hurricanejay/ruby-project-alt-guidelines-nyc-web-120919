require_relative '../config/environment'
require 'pry'
require 'tty-prompt'

class CLI

    PROMPT = TTY::Prompt.new


    def start
      self.welcome_menu
    end

    def welcome_menu
      PROMPT.select "Hi, Welcome to Real Rental Reviews!"  do |menu|
        menu.choice "Login", -> { login }
        menu.choice "Create an Account", -> { create_account }
        menu.choice "Exit"
      end
    end

      def create_account
      user_input = PROMPT.ask "Type in your Name"
      @user = User.create(name: user_input)
      main_menu
      end
    
      def login
        user_input = PROMPT.ask "Name"
        @user = User.find_by(name: user_input)
        main_menu
   
      end

    def main_menu

    PROMPT.select ("Please select one of the following options:")  do |menu|
    menu.choice "Write a Review", -> { write_review }
    menu.choice "Read Reviews", -> { read_review }
    menu.choice "My Reviews", -> { my_review }
    menu.choice "Exit"
        end
      end

    def write_review
      user_input = PROMPT.collect do
        key(:address).ask('Address')
        key(:unit).ask('Unit Number')
        key(:rating).ask('Rate 1-Poor, 2-Average, 3-Great')
        key(:content).ask('Please write your review')

      end
        new_rental = Rental.create(address: user_input[:address])
       Review.create(user_id: @user.id, rental_id: new_rental.id, unit: user_input[:unit], rating: user_input[:rating], content: user_input[:content])
      main_menu
    end

    def read_review
      PROMPT.select ("Would you like to:")  do |menu|
        menu.choice "Search Reviews", -> { enter_address }
        menu.choice "Read All Reviews", -> { all_reviews }
        menu.choice "Exit"
    end
  end
  
    def enter_address
      user_input = PROMPT.ask "Please enter an address to begin search"
      target_rental = Rental.find_by(address: user_input)

     if target_rental
      target_rental.reviews.each do |review|
        puts review.content
     end
      else 
           puts "Sorry, could not find the address entered."
        end
        main_menu
      end

      def all_reviews
        all_reviews = Review.all
        all_reviews.each do |review|
          puts "----------------"
          puts "Reviewer: #{User.find_by(id: review.user_id).name}"
          puts "Address: #{review.rental.address}"
          puts "Rating: #{review.rating}"
          puts "Review: #{review.content}"
          puts "----------------"
        end
        main_menu
      end

  
    def my_review
      PROMPT.select ("Would you like to:")  do |menu|
        menu.choice "Edit Review", -> { edit_review }
        menu.choice "Delete Review", -> { delete_review }
        menu.choice "Main Menu", -> { main_menu }
        menu.choice "Exit"
    end
  end

      def edit_review
      edit_review = Review.all
      edit_review.select do |review|
       if review.user_id == @user.id
        puts "----------------"
        puts "#{review.id}: Name #{@user.name}"
        puts "Address: #{review.rental.address}"
        puts "Rating: #{review.rating}"
        puts "Review: #{review.content}"
        puts "----------------"
        end
       end

       user_input = PROMPT.ask('Please enter the review number that you would like to edit:')

       find_id = Review.find_by(id: user_input)

       new_review = PROMPT.ask('Please submit a new review.')

       find_id.content = new_review

       new_rating = PROMPT.ask('Please submit a new rating. Rate 1-Poor, 2-Average, 3-Great')

       find_id.rating = new_rating
  
       find_id.save
     main_menu
     end


  def delete_review

    delete_review = Review.all
      delete_review.select do |review|
       if review.user_id == @user.id
        puts "----------------"
        puts "#{review.id}: Name #{@user.name}"
        puts "Address: #{review.rental.address}"
        puts "Rating: #{review.rating}"
        puts "Review: #{review.content}"
        puts "----------------"
        end
      end
      user_input = PROMPT.ask('Please enter the review number that you would like to delete')

      find_id = Review.find_by(id: user_input)

    user_input = PROMPT.yes?('Do you want to delete your review?')
      if user_input == true 
        find_id.destroy
      end
      main_menu
    end

  end
