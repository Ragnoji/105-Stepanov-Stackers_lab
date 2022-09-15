def maskify(s)
  s.gsub(/.(?=.{4})/, '#')
end

stroka = "password"
puts maskify(stroka)
