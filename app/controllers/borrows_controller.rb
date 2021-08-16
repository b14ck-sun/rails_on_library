class BorrowsController < ApplicationController

    def index
        @borrows = Borrow.all
        # Borrow.find_in_batches(batch_size: 5) do |group|
        #     @borrows = group
        #     # group.each { |person| person.party_all_night! }
        # end
    end

    def giveback
        @borrow = Borrow.find(params[:id])
        if @borrow.user == current_user
            @borrow.return_book!
            redirect_to "/borrows"
        end
    end

    def give_credit
        new_credit = current_user.debt + 100
        current_user.update(debt: new_credit)
        redirect_to "/borrows"
    end
    
    def create
        @book = Book.find(params[:id])
        @borrows = Borrow.where(user:current_user, state: :borrowed).count
        if @borrows < ENV.fetch("MaxNum").to_i
            Borrow.create(book:@book, user:current_user)
            redirect_to root_path
        else
            render :template => "borrows/failed"
        end        
    end

end
