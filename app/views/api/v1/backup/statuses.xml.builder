xml.instruct!
xml.statuses(type: :array) do
  @statuses.each do |status|
    xml.status do
      xml << render(partial: 'api/v1/backup/status.xml',
                    locals: { status: status })
    end # xml.status
  end
end # xml.statuses
