class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :year, :actors, :directors

  def actors
    object.people.joins(:positions).where("positions.title LIKE 'Actor'").select('people.*, positions.title as position')
  end

  def directors
    object.people.joins(:positions).where("positions.title LIKE 'Director'").select('people.*, positions.title as position')
  end
end
