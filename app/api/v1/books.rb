module V1
    class Books < Grape::API
      
      helpers do
        def current_user
          # @current_user ||= User.authorize!(env)
          @current_user = User.find(params[:user_id])
        end
  
        def authenticate!
          error!('401 Unauthorized', 401) unless current_user
        end
      end

      resource :books do

        desc "Return all books"
        get "", root: :books do
          Book.all
        end

        desc "Return a book"
        params do
          requires :id, type: String, desc: "ID of the 
            book"
        end
        get ":id", root: "book" do
          Book.where(id: params[:id]).first!
        end

        desc 'Create a book.'
        params do
          requires :title, type: String, desc: 'Book title'
          requires :writer, type: String, desc: 'Book writer'
          requires :cost, type: Integer, desc: 'Book cost'
          requires :limit, type: Integer, desc: 'Book limit'
          requires :user_id, type: Integer, desc: 'User'
        end
        post do
          authenticate!
          Book.create!(title:params[:title], writer:params[:writer], cost:params[:cost], limit:params[:limit], user:current_user)
        end

        desc 'Update a Book.'
        params do
          requires :title, type: String, desc: 'Book title'
          requires :writer, type: String, desc: 'Book writer'
          requires :cost, type: Integer, desc: 'Book cost'
          requires :limit, type: Integer, desc: 'Book limit'
          requires :user_id, type: Integer, desc: 'User'
        end
        put ':id' do
          authenticate!
          if Book.find(params[:id]).user_id == current_user.id
            Book.find(params[:id]).update({
              title: params[:title],
              writer: params[:writer],
              cost: params[:cost],
              limit: params[:limit]
            })
          end
        end
  
        desc 'Delete a book.'
        params do
          requires :user_id, type: Integer, desc: 'User'
        end
        delete ':id' do
          authenticate!
          if Book.find(params[:id]).user_id == current_user.id
            Book.find(params[:id]).destroy
          end
        end

      end
    end
  end