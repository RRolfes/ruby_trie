# class TrieNode
class TrieNode
  attr_reader :letter, :children
  attr_accessor :is_word, :full_word
  def initialize(letter = nil, children = [], is_word = false)
    @letter = letter
    @children = children
    @is_word = is_word
    @full_word
  end

  # creates and adds a new node to children array
  # and returns it so the new node can be added to via
  # Trie#add(word)

  def add_child(letter)
    # prevents duplicate children with same letter
    return get_child(letter) if has_child?(letter)

    child = TrieNode.new(letter)
    @children << child
    # return the child to allow chaining for Trie creation
    child
  end

  # checks if a node has a child/letter and returns a boolean
  def has_child?(letter)
    @children.each do |node|
      return true if node.letter == letter
    end

    false
  end

  # returns a child node if letter matches
  def get_child(letter)
    @children.each do |child|
      return child if child.letter == letter
    end
  end
end

# class Trie
class Trie
  def initialize(words = [])
    @root = TrieNode.new
    words.each do |word|
      add_word(word)
    end
  end

  def add_word(word)
    letters = word.split('')
    current_node = @root
    letters.each_with_index do |letter, i|
      child = current_node.add_child(letter)
      child.full_word = word[0..i]
      current_node = child
    end

    current_node.is_word = true
  end

  # returns the starting node (i.e. node of last letter in str)
  def get_start(str)
    node = @root
    str.length.times do |i|
      return nil unless node.has_child?(str[i])
      node = node.get_child(str[i])
    end
    node
  end

  # searches for a word and returns true or false if found in trie
  def has_word?(str)
    node = @root
    str.size.times do |i|
      return false unless node.has_child?(str[i])
      node = node.get_child(str[i])
    end
    true
  end

  # returns an array of all words that begin with str
  def search(str)
    start = get_start(str)
    return "No results with prefix '#{str}'" if start.nil?

    find_words(start)
  end

  # takes starting node and performs BFS; stores full words to arr
  def find_words(node)
    words = []
    queue = []
    words << node.full_word if node.is_word
    queue << node
    until queue.empty? do
      node = queue.shift
      node.children.each do |child_node|
        word = child_node.full_word
        words << word if child_node.is_word
        queue << child_node
      end
    end
    words
  end
end

words = ['hello', 'hell', 'hellish', 'hope', 'helicopter']
a = Trie.new(words)
p a.search('hello')
p a.has_word?('hell')
