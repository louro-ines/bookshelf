require 'rails_helper'

describe 'Books API', type: :request do
  let(:author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell', age: 99) }

  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title:'1984', author: author)
      FactoryBot.create(:book, title:'Animal Farm', author: author)
    end

    it 'returns all books' do
      get '/api/v1/books'

      #checks that the response status is a 200
      expect(response).to have_http_status(:success)

      #checks that there are actuall books being returned
      expect(response_body.size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do

      # checks that the book was actually created
      # by comparing the number of rows in the database before and after the post request
      expect {
        post '/api/v1/books', params: {
          book: { title: 'The Bitcoin Standard' },
          author: {first_name: 'Saifedean', last_name: 'Ammous', age: 40 }
        }
      }.to change { Book.count }.from(0).to(1)

      #because when we create a book we first create an author
      expect(Author.count).to eq(1)

      #checks the response code
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    # creating the factory w/ no lazy loading (!) so that we have a book when the test runs
    # and assign it to the let variable book
    let!(:book) { FactoryBot.create(:book, title:'1984', author: author) }

    it'deletes a book' do

      # checks that the book was actually deleted
      # by comparing the number of rows in the database before and after the delete request
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      #checks the response code
      expect(response).to have_http_status(:no_content)
    end
  end
end
