require 'rails_helper'

describe 'API', type: :request do
  describe 'GET /authors' do
    before do
      FactoryBot.create(:author)
      FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell', age: 99)
    end

    it 'returns all authors' do
      get '/api/v1/authors'

      #checks that the response status is a 200
      expect(response).to have_http_status(:success)

      #checks that there are actuall authors being returned
      expect(response_body.size).to eq(2)

      #checks the actual content of response
      expect(response_body).to eq(
        [
          {
            'id' => 1,
            'name' => 'Saifedean Ammous',
            'age' => 40
          },
          {
            'id' => 2,
            'name' => 'George Orwell',
            'age' => 99
          }
        ]
      )
    end
  end

  describe 'POST /authors' do
    it 'create a new author' do
      # checks that the author was actually created
      # by comparing the number of rows in the database before and after the post request
      expect {
        post '/api/v1/authors', params: {
          author: { first_name: 'Andreas', last_name: 'Antonopoulos', age: 50 },
        }
      }.to change { Author.count }.from(0).to(1)

      #because when we create a author we first create an author
      expect(Author.count).to eq(1)

      #checks the response code
      expect(response).to have_http_status(:created)

      #checks the actual content of response
      expect(response_body).to eq(
        {
          'id' => 1,
          'name' => 'Andreas Antonopoulos',
          'age' => 50
        }
      )
    end
  end
end
