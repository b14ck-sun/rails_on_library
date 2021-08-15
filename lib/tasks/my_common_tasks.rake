namespace :my_common_tasks do
  desc "List books with only one copy left "
  task limited_books: :environment do
    borrows = Borrow.where(state: "borrowed")
    b_b = {}
    s_b = []
    borrows.each do |borrow|
      if b_b.key?(borrow.book.title)
        b_b[borrow.book.title] -= 1
        # check for one or less
        if b_b[borrow.book.title] <= 1
          # puts "#{borrow.book.title} is running out"
          s_b.append(borrow.book.title)
        end
      else 
        b_b[borrow.book.title] = borrow.book.limit - 1
        # check for one or less
        if b_b[borrow.book.title] <= 1
          # puts "#{borrow.book.title} is running out"
          s_b.append(borrow.book.title)
        end
      end
    end
    # bh = books.as_json
    puts "Following books are running out: "
    puts s_b
  end

end
