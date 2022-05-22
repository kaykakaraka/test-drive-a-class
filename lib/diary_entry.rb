class DiaryEntry
  def initialize(title, contents) # title, contents are strings
    fail "Error: No title entered" if title == ""
    @title = title
    @contents = contents
    @begin_from = 0
  end

  def title
    @title
  end

  def contents
    @contents
  end

  def count_words
    @contents.split(" ").count
  end

  def reading_time(wpm) # wpm is an integer representing the number of words the
    (count_words.to_f / wpm).round                   # user can read per minute
  end

  def reading_chunk(wpm, minutes) # `wpm` is an integer representing the number
    @begin_from = 0 if @begin_from >= count_words - 1 #begin from the beginning if end of text has been reached

    end_at = @begin_from + (wpm * minutes - 1) #calculates where to end reading
    chunk_to_read = @contents.split(" ")[@begin_from..(end_at)].join(" ")   #extracts the chunk of text 
                          
    @begin_from += chunk_to_read.split(" ").count
    
    chunk_to_read                
  end
end