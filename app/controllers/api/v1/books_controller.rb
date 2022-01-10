module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[update show destroy]
      def index
        @books = Book.all
        render json: BooksRepresenter.new(@books).as_json
      end

      def show
        render json: BookRepresenter.new(@book).as_json
      end

      def create
        @book = Book.new(book_params)

        if @book.save
          render json: BookRepresenter.new(@book).as_json, status: :created #201
        else
          render json: @book.errors, status: :unprocessable_entity #422
        end
      end

      def update
        @book.update(book_params)
        head :no_content
      end

      def destroy
        @book.destroy!

        head :no_content #204
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author_id)
      end
    end
  end
end
