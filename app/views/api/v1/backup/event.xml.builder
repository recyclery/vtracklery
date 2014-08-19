xml.instruct!
xml.event do
  xml << render(partial: 'api/v1/backup/event.xml',
                locals: { event: @event })
end # xml.event
