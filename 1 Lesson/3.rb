def shortest_word(s)
  s.split.min { |a, b| a.size <=> b.size }.size
end

print shortest_word("bitcoin take over the world maybe who knows perhaps")