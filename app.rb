require_relative 'teacher'
require_relative 'student'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @books = []
    @peoples = []
  end

  def list_all_books
    @books.each { |book| puts "Title = #{book.title} Author = #{book.author}" }
  end

  def list_all_peoples
    @peoples.each { |people| puts "Name = #{people.name} ID = #{people.id} Age = #{people.age}" }
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Classroom: '
    classroom = gets.chomp
    print 'Has parent permission? (Y/N): '
    parent_permission = gets.chomp.downcase
    while parent_permission != 'y' && parent_permission != 'n'
      print 'Has parent permission? (Y/N): '
      parent_permission = gets.chomp.downcase
    end
    student = Student.new(age, classroom, name, parent_permission: true) if parent_permission == 'y'
    student = Student.new(age, classroom, name, parent_permission: false) if parent_permission == 'n'
    @peoples << student
    puts 'Person Created Successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    @peoples << Teacher.new(specialization, age, name)
    puts 'Person Created Successfully'
  end

  def create_person
    puts 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
    number = gets.chomp
    while number != '1' && number != '2'
      puts 'Do you want to create a student(1) or a teacher(2)? [Input the number 1 or 2 only]: '
      number = gets.chomp
    end
    if number == '1'
      create_student
    else
      create_teacher
    end
  end

  def create_book
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index} Title = #{book.title} Author = #{book.author}" }
    number = gets.chomp.to_i
    puts 'Select a person from the following list by number(not ID)'
    @peoples.each.with_index do |person, index|
      puts "#{index}) #{[person.class.name]} Name #{person.name}, ID #{person.id}, Age #{person.age}"
    end
    person_index = gets.chomp.to_i
    puts 'Date(YYYY-MM-DD)'
    date = gets.chomp
    Rental.new(date, @peoples[person_index], @books[number])
    puts 'Rental created successfully'
  end

  def list_rentals
    print 'ID of a person: '
    id = gets.chomp.to_i
    @peoples.each do |person|
      next unless person.id == id

      puts 'Rentals:'
      person.rentals.each do |rental|
        puts "Date #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
      end
    end
  end
end
