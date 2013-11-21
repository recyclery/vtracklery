xml.instruct!
xml.event do
  xml << render(partial: 'events/event', locals: {event: @event})
end # xml.event
