class VerticalRepresenter

  def initialize(vertical)
    @vertical = vertical
  end

  def as_json
    {
      id: vertical.id,
      name: vertical.name
    }
  end

  private
  attr_reader :vertical
end
