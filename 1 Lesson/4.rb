def plural_index(quantity)
  if quantity.to_s[-2] != '1' && quantity % 10 == 1
    0
  elsif quantity.to_s[-2] != '1' && quantity % 10 < 5
    1
  else
    2
  end
end

def enum_array(input_array)
  tmp_hash = {}
  plural_forms = { "Стол" => %w[Стол Стола Столов], "Ручка" => %w[Ручка Ручки Ручек], "Сапог" => %w[Сапог Сапога Сапог] }
  input_array.each { |item| tmp_hash[item] = input_array.count(item) }
  tmp_hash.each.map { |key, value| "#{value} #{plural_forms[key][plural_index(value)]}" }.join(", ")
end

print enum_array( [ "Стол", "Сапог", "Стол", "Ручка", "Сапог", "Сапог", "Сапог", "Сапог" ])