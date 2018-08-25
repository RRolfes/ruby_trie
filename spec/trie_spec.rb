require 'trie'

describe TrieNode do
  subject(:node) { TrieNode.new('r') }

  describe '#initialize' do
    it 'sets char to char provided' do
      expect(node.char).to eq('r')
    end
  end
end
