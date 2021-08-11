class CreditCollectorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # puts "I am Kewl"
    for us in User.all
      price = 0
      # us.borrows.where(state: 'borrowed')
      for rec in Borrow.all
        byebug
        if (rec.user == us && rec.state = "borrowed")
          puts rec.state
          puts rec.book.title
          puts "**************************************"
          current_book = rec.book.title
          cb = Book.find_by(title: current_book)
          price += cb.cost
        end
      end
      puts "#{us.email} should pay #{price}"
      puts '////////////////////////'
    end
  end
end
