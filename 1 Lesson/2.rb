def edit(s)
  s.downcase.each_char.map { |char| s.count(char) > 1 ? ")" : "(" }.join("")
end

print edit("(( @")