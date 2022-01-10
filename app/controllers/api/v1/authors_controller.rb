module Api
  module V1
    class AuthorsController < ApplicationController
      def index
        @authors = Author.all
        render json: AuthorsRepresenter.new(@authors).as_json
      end

      def create
        @author = Author.new(author_params)

        if @author.save
          render json: AuthorRepresenter.new(@author).as_json, status: :created #201
        else
          render json: @author.errors, status: :unprocessable_entity #422
        end
      end

      private
      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

    end
  end
end
