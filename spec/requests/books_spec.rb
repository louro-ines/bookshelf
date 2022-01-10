require 'rails_helper'

describe 'API Book', type: :request do
  let(:author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell', age: 99) }

  describe 'GET /books' do
    before do
      FactoryBot.create(:book)
      FactoryBot.create(:book, title:'Animal Farm', author: author)
    end

    it 'returns all books' do
      get '/api/v1/books'

      #checks that the response status is a 200
      expect(response).to have_http_status(:success)

      #checks that there are actuall books being returned
      expect(response_body.size).to eq(2)

      #checks the actual content of response
      expect(response_body).to eq(
        [
          {
            'id' => 1,
            'title' => 'The Bitcoin Standard',
            'author_name' => 'Saifedean Ammous',
            'author_age' => 40
          },
          {
            'id' => 2,
            'title' => 'Animal Farm',
            'author_name' => 'George Orwell',
            'author_age' => 99
          }
        ]
      )
    end
  end

  describe 'GET /books/:id' do
    let(:book) { FactoryBot.create(:book) }

    it 'returns the book item' do
      get "/api/v1/books/#{book.id}"

      #checks that the response status is a 200
      expect(response).to have_http_status(:success)

      #checks that the book we whant is being returned
      expect(response_body['id']).to eq(book.id)

      #checks the actual content of response
      expect(response_body).to eq(
        {
          'id' => 1,
          'title' => 'The Bitcoin Standard',
          'author_name' => 'Saifedean Ammous',
          'author_age' => 40
        }
      )
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      # checks that the book was actually created
      # by comparing the number of rows in the database before and after the post request
      expect {
        post '/api/v1/books', params: {
          book: { title: '1984', author_id: author.id },
        }
      }.to change { Book.count }.from(0).to(1)

      #because when we create a book we first create an author
      expect(Author.count).to eq(1)

      #checks the response code
      expect(response).to have_http_status(:created)

      #checks the actual content of response
      expect(response_body).to eq(
        {
          'id' => 1,
          'title' => '1984',
          'author_name' => 'George Orwell',
          'author_age' => 99
        }
      )
    end
  end

  describe 'POST /books/:id' do
    let(:book) { FactoryBot.create(:book) }
    let(:new_title) { { title: 'The Fiat Standard' } }

    it 'updates the book we wanted' do
      put "/api/v1/books/#{book.id}", params: { book: new_title }

      #checks the response code
      expect(response).to have_http_status(:no_content)

      # checks that the book was actually updated
      updated_item = Book.find(book.id)
      expect(updated_item.title).to match(/The Fiat Standard/)
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
