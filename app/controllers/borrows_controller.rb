class BorrowsController < ApplicationController

    def index
        @borrows = Borrow.all
    end

    def giveback
        @borrow = Borrow.find(params[:id])
        if @borrow.user == current_user
            @borrow.update(state:"returned")
            redirect_to "/borrows"
        end
    end

    def give_credit
        ncr = current_user.Debt - 100
        # if current_user.Debt then ncr = current_user.Debt - 100 else ncr = -100 end
        current_user.update(Debt: ncr)
        puts "Debt Cleared"
        redirect_to "/borrows"
    end
    
    def create
        @book = Book.find(params[:id])
        @borrows = Borrow.where(book:@book, state:"borrowed").count
        if @borrows < @book.limit
            Borrow.create(book:@book, user:current_user, state:"borrowed")
        end        
        redirect_to root_path
      end

end
