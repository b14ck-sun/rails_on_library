class BorrowsController < ApplicationController

    def index
        @borrows = Borrow.all
        # @env = ENV.fetch("MaxNum")
    end

    def giveback
        @borrow = Borrow.find(params[:id])
        if @borrow.user == current_user
            @borrow.update(state:"returned")
            redirect_to "/borrows"
        end
    end

    def give_credit
        new_credit = current_user.Debt + 100
        # if current_user.Debt then new_credit = current_user.Debt - 100 else new_credit = -100 end
        current_user.update(Debt: new_credit)
        puts "Debt Cleared"
        redirect_to "/borrows"
    end
    
    def create
        @book = Book.find(params[:id])
        @borrows = Borrow.where(book:@book, state:"borrowed").count
        if @borrows < ENV.fetch("MaxNum").to_i
            Borrow.create(book:@book, user:current_user, state:"borrowed")
            redirect_to root_path
        else
            # redirect_to root_path
            # redirect_to action: failed
            render :template => "borrows/failed"
        end        
    end

end
