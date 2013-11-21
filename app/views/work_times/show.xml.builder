xml.instruct!
xml.work_time do
  xml << render(partial: 'work_times/work_time',
                locals: {work_time: @work_time})
end # xml.work_time
