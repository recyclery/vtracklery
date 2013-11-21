xml.instruct!
xml.work_times(type: :array) do
  @work_times.each do |work_time|
    xml.work_time do
      xml << render(partial: 'work_times/work_time',
                    locals: {work_time: work_time})
    end # xml.work_time
  end
end # xml.work_times
