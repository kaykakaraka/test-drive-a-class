require "diary_entry"

RSpec.describe DiaryEntry do
  
  context "User enters a title and contents" do
    it "returns the title as a string" do
      diary_entry = DiaryEntry.new("Tuesday morning", "We went for a lovely walk.")
      result = diary_entry.title
      expect(result).to eq "Tuesday morning"
    end

    it "returns the contents as a string" do
      diary_entry = DiaryEntry.new("Tuesday morning", "We went for a lovely walk.")
      result = diary_entry.contents
      expect(result).to eq "We went for a lovely walk."
    end

    it "returns the number of words in the contents of the diary as an integer" do
      diary_entry = DiaryEntry.new("The third of June", "What a wonderful day! I had a great time.") 
      result = diary_entry.count_words
      expect(result).to eq 9
    end

    it "returns an estimate of reading time for the user for the contents of the diary" do
      diary_entry = DiaryEntry.new("The fourth of June", "content " * 400)
      result = diary_entry.reading_time(100)
      expect(result).to eq 4
    end
  end
  
  context "user enters a title but no contents" do
    it "returns empty contents" do
      diary_entry = DiaryEntry.new("The fourth of June", "")
      result = diary_entry.contents
      expect(result).to eq ""
    end
  end

  context "user enters no title and no contents" do
    it "fails" do
      expect { DiaryEntry.new("", "") }.to raise_error "Error: No title entered" 
    end
  end

  context "user enters contents but no title" do
    it "fails" do
      expect { DiaryEntry.new("", "What a lovely day today was.") }.to raise_error "Error: No title entered"
    end
  end

  context "number of words to read is not divisible by the wpm" do
    it "returns a rounded estimate of reading time" do
      diary_entry = DiaryEntry.new("The fifth of June", "content " * 388)
      result = diary_entry.reading_time(50)
      expect(result).to eq 8
    end
  end

  context "reader does not have time to read the whole text" do 
    it "returns a chunk of text that the reader could read in a given time" do
      diary_entry = DiaryEntry.new("The sixth of June", "content " * 8000)
      result = diary_entry.reading_chunk(1, 4)
      expect(result).to eq ("content content content content")
    end

    it "returns the next chunk of text that the reader could read in a given time when asked twice" do
      diary_entry = DiaryEntry.new("The sixth of June", "I absolutely love reading. It is such a pleasure!!")
      first_read = diary_entry.reading_chunk(1, 4)
      result = diary_entry.reading_chunk(1,5)
      expect(result).to eq ("It is such a pleasure!!")
    end

    it "returns to the beginning of the text if the reader has read exactly to the end" do
      diary_entry = DiaryEntry.new("The sixth of June", "I absolutely love reading. It is such a pleasure!!")
      first_read = diary_entry.reading_chunk(1, 4)
      second_read = diary_entry.reading_chunk(1, 5)
      result = diary_entry.reading_chunk(1, 3)
      expect(result).to eq "I absolutely love"
    end

    it "stops at the end of the text even if reader has more time to read" do
      diary_entry = DiaryEntry.new("The seventh of June", "I absolutely love reading. It is such a pleasure!!")
      first_read = diary_entry.reading_chunk(1, 4)
      result = diary_entry.reading_chunk(20, 5)
      expect(result).to eq "It is such a pleasure!!"
    end
  end
end