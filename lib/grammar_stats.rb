class GrammarStats
  def initialize
    @acceptable_punctuation = [".", "?", "!"]
    @test_results = []
  end

# Returns true or false depending on whether the text begins with a capital
# letter and ends with a sentence-ending punctuation mark.
  def check(text) # text is a string
    fail "Error: method can only check a string" if !text.is_a? String 
    result = text[0] == text[0].upcase && @acceptable_punctuation.include?(text[-1])
    @test_results << result
    result
  end

# Returns as an integer the percentage of texts checked so far that passed
# the check defined in the `check` method. The number 55 represents 55%.
  def percentage_good
    fail "Error: you must check a text first" if @test_results.empty?
    true_count = 0
    @test_results.each { |answer| true_count += 1 if answer == true }
    (true_count.to_f / (@test_results.count) * 100).round
  end

end