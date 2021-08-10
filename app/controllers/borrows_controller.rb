class BorrowsController < ApplicationController

    def index
        @borrows = Borrow.all
    end

    def return
        @borrow = Borrow.find(params[:id])
        if @borrow.user == current_user
            @borrow.update(state:"returned")
            redirect_to "/borrows"
        end
    end
    
    def create
        @book = Book.find(params[:id])
        @borrows = Borrow.where(book:@book, state:"borrowed")
        if @borrows.count < @book.limit
            @borrow = Borrow.new(book:@book, user:current_user, state:"borrowed")
            @borrow.save
        end        
        # nv =  @book.limit - 1
        # # @book.update(@book.title,@book.writer, @book.creator, @book.limit, @book.cost)
        # if nv >= 0
        #   @book.update_attribute(:limit, nv)
        #   # @book.update(limit: nv)
        # end
        redirect_to root_path
      end

end
