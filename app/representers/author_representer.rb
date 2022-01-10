class AuthorRepresenter
  def initialize(author)
    @author = author
  end

  def as_json
      {
        id: author.id,
        name: "#{author.first_name} #{author.last_name}",
        age: author.age
      }
  end

  private

  attr_reader :author
end
