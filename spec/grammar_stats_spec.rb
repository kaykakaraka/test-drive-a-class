require "grammar_stats"

RSpec.describe GrammarStats do

  context "user checks a text that begins with a capital letter and a full stop" do
    it "returns true" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("I'm having a lovely day at the beach.")
      expect(result).to eq true
    end
  end

  context "user checks a text that does not begin with a capital letter but ends with a full stop" do
    it "returns false" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("it's so beautiful outside.")
      expect(result).to eq false
    end
  end

  context "user checks a text that begins with a capital letter but doesn't end with any punctuation" do
    it "returns false" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("It's so beautiful outside")
      expect(result).to eq false
    end
  end

  context "user checks a text that begins with a capital letter and ends with a question mark" do
    it "returns true" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("How are you doing today?")
      expect(result).to eq true
    end
  end  

  context "user checks a text that begins with a capital letter and ends with an exclamation mark" do
    it "returns true" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("I love walking outside!")
      expect(result).to eq true
    end
  end

  context "user checks a text that doesn't with a capital letter or end with punctuation" do
    it "returns true" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("i love walking outside")
      expect(result).to eq false
    end
  end

  context "user checks a text that begins with a capital letter and ends with a comma" do
    it "returns false" do
      grammar_stats = GrammarStats.new
      result = grammar_stats.check("I love walking outside,")
      expect(result).to eq false
    end
  end

  context "user checks a text that isn't a string" do
    it "fails" do
      grammar_stats = GrammarStats.new
      expect { grammar_stats.check(90) }.to raise_error "Error: method can only check a string"
    end
  end

  context "text is nil for check method" do
    it "fails" do
      grammar_stats = GrammarStats.new
      expect {grammar_stats.check(nil) }.to raise_error "Error: method can only check a string"
    end
  end

  context "user checks 1 text which passes" do
    it "returns 100% from percentage_good" do
      grammar_stats = GrammarStats.new
      grammar_stats.check("That's wonderful!")
      result = grammar_stats.percentage_good
      expect(result).to eq 100
    end
  end

  context "user check 5 texts, 4 pass and 1 fails" do
    it "returns 80% from percentage_good" do
      grammar_stats = GrammarStats.new
      grammar_stats.check("That's wonderful!")
      grammar_stats.check("I love eating.")
      grammar_stats.check("I don't know")
      grammar_stats.check("That's nice.")
      grammar_stats.check("Why?")
      result = grammar_stats.percentage_good
      expect(result).to eq 80
    end
  end
  
  context "user checks 5 failing texts, runs percentage_good" do
    it "returns 0%" do
      grammar_stats = GrammarStats.new
      grammar_stats.check("that's wonderful")
      grammar_stats.check("I love eating")
      grammar_stats.check("i don't know")
      grammar_stats.check("That's nice")
      grammar_stats.check("why?")
      result = grammar_stats.percentage_good
      expect(result).to eq 0
    end
  end

  context "user runs percentage_good before checking and text" do
    it "fails" do
      grammar_stats = GrammarStats.new
      expect { grammar_stats.percentage_good }.to raise_error "Error: you must check a text first"
    end
  end
  
  it "returns a rounded percentage" do
    grammar_stats = GrammarStats.new
    grammar_stats.check("Hi.")
    grammar_stats.check("hi")
    grammar_stats.check("hi")
    grammar_stats.check("hi.")
    grammar_stats.check("hi.")
    grammar_stats.check("hi.")
    result = grammar_stats.percentage_good
    expect(result).to eq 17
  end
end