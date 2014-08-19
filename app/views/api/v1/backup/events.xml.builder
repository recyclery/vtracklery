xml.instruct!
xml.events(type: :array) do
  @events.each do |event|
    xml.event do
      xml << render(partial: 'api/v1/backup/event.xml',
                    locals: { event: event })
    end # xml.event
  end
end # xml.events
