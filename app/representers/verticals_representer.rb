class VerticalsRepresenter

  def initialize(verticals)
    @verticals = verticals
  end

  def as_json
    verticals.map do |vertical|
      {
        id: vertical.id,
        name: vertical.name
      }
    end
  end

  private
  attr_reader :verticals
end
