xml.instruct!
xml.events(type: :array) do
  @events.each do |event|
    xml.event do
      xml << render(partial: 'events/event', locals: {event: event})
    end # xml.event
  end
end # xml.events
