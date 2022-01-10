class AuthorsRepresenter
  def initialize(authors)
    @authors = authors
  end

  def as_json
    authors.map do |author|
      {
        id: author.id,
        name: "#{author.first_name} #{author.last_name}",
        age: author.age
      }
    end
  end

  private

  attr_reader :authors
end
