class BookRepresenter
  def initialize(book)
    @book = book
  end

  def as_json
      {
        id: book.id,
        title: book.title,
        author_name: "#{book.author.first_name} #{book.author.last_name}",
        author_age: book.author.age
      }
    end
  end

  private

  attr_reader :book
end
