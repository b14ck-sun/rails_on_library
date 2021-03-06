class CommentsController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        @comment = @book.comments.create(body: comment_params[:body], original_body: comment_params[:body], state: "Original", user: current_user)
        redirect_to book_path(@book)
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
