require 'rails_helper'

describe 'Books API', type: :request do
  it 'returns all books' do
    FactoryBot.create(:book, title:'1984', author:'George Orwell')
    FactoryBot.create(:book, title:'Animal Farm ', author:'George Orwell')

    get '/api/v1/books'

    #checks that the response status is a 200
    expect(response).to have_http_status(:success)

    #checks that there are actuall books being returned
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
