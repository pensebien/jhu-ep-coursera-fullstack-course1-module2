#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count
  attr_reader :highest_wf_words
  attr_reader :content
  attr_reader :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize(content, line_number)
    @content           = content
    @line_number       = line_number
    @highest_wf_count   = 0
    @highest_wf_words   = []
    calculate_word_frequency()
  end

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.


  def content 
    @content
  end

  def line_number
    @line_number
  end

  def calculate_word_frequency()
    dict = {}

    words_in_content = @content.downcase.split(/\W+/)

    for word in words_in_content  do
     
      if dict[word] == nil
        dict[word] = 1
      else 
        dict[word] += 1
      end 

      if dict[word] > @highest_wf_count
        @highest_wf_count = dict[word]
      end
    end

    
    @highest_wf_words = dict.select{|key, value| value == @highest_wf_count}.keys
    
    
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end


#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  
  attr_reader :analyzers
  attr_reader :highest_count_across_lines
  attr_reader :highest_count_words_across_lines

  def initialize()
    @@analyzers                       = []
  end

  def analyzers
    @@analyzers
  end

  def highest_count_across_lines
    @highest_count_across_lines 
  end

  def highest_count_words_across_lines
    @highest_count_words_across_lines 
  end

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  def analyze_file

    path                  = File.join(File.dirname(__FILE__), "test.txt")
    file                  = File.open(path, 'r+')
    line_number           = 1

    File.foreach(file) do |line|
      content = line.chomp
   
      new_line_analyzer   = LineAnalyzer.new(content, line_number)
    
      @@analyzers.push(new_line_analyzer)

      
      # @@analyzers.each do |line|
      #   p line.content
      #   p line_number
      #   p @@analyzers.length
      #   puts "++++++++++++++++++++"
      # end

      line_number         +=1

      

    end

    4.times do |index| 
      if index > 0 
        p @@analyzers[index-1].content
        p index
      end 
    end 

  end
  


  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines       = 0
    @highest_count_words_across_lines = []
    for line in @@analyzers
      if line.highest_wf_count >= @highest_count_across_lines

        @highest_count_across_lines = line.highest_wf_count
        @highest_count_words_across_lines.push(line)
           
      end
      
    end
  end

  #Implement the print_highest_word_frequency_across_lines() method tos
  #* print the values of objects in highest_count_words_across_lines in the specified format

  def print_highest_word_frequency_across_lines
    for line in @highest_count_words_across_lines
      puts "#{line.highest_wf_words} (appears in line #{line.line_number} )"
    end
  end

end


solution = Solution.new()
solution.analyze_file
solution.calculate_line_with_highest_frequency
# words_found = solution.highest_count_words_across_lines.map(&:highest_wf_words).flatten

solution.print_highest_word_frequency_across_lines
