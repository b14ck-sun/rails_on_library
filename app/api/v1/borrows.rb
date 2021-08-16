module V1
    class Borrows < Grape::API

      helpers do
        def current_user
          # @current_user ||= User.authorize!(env)
          @current_user = User.find(params[:user_id])
        end
  
        def authenticate!
          error!('401 Unauthorized', 401) unless current_user
        end
      end

      resource :borrows do

        desc "Return all borrows"
        get "", root: :borrows do
          Borrow.all
        end

        desc "Return a Record"
        params do
          requires :id, type: String, desc: "ID of the 
            Record"
        end
        get ":id", root: "Record" do
          Borrow.where(id: params[:id]).first!
        end

        desc 'Borrow a book.'
        params do
          requires :book_id, type: Integer, desc: 'Book id'
          requires :user_id, type: Integer, desc: 'User'
        end
        post do
          authenticate!
          book = Book.find(params[:book_id])
          Borrow.create!(book: book, user: current_user)
        end

        desc 'Return a Book.'
        params do
            requires :user_id, type: Integer, desc: 'User'
        end
        put ':id' do
          authenticate!
          # byebug
          @bor = Borrow.find(params[:id])
          if @bor.user_id == current_user.id
            @bor.return_book!
            # @bor.save
            # puts @bor.state
            # Borrow.find(params[:id]).update(state:"returned")
          end
        end

      end
    end
  end