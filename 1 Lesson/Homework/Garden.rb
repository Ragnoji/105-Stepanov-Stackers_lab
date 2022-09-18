class Raspberry
  @@states = %i[Отсутствует Цветение Зеленая Красная]

  def initialize(index)
    @index = index
    @state = @@states[0]
  end

  def grow!
    unless ripe?
      @@states.each_cons(2) do |state, next_state|
        if state == @state
          @state = next_state
          return
        end
      end
    end
  end

  def ripe?
    @state == :Красная
  end

  def grab!
    @state = @@states.first
  end
end

class RaspberryBush
  attr_reader :berries_quantity

  def initialize(berries_quantity)
    @berries_quantity = berries_quantity
    @raspberries = berries_quantity.times.map { |i| Raspberry.new(i) }
  end

  def grow_all!
    @raspberries.map(&:grow!)
  end

  def ripe_all?
    @raspberries.map(&:ripe?).all?
  end

  def give_away_all!
    @raspberries.each { |berry| berry.grab! }
  end
end

class Human
  attr_reader :name, :money
  @@price_per_berry = 2
  
  def initialize(name, plant)
    @name = name
    @plant = plant
    @amount_of_harvested_berries = 0
    @statistic_of_harvested_berries = 0
    @money = 0
  end

  def work!
    puts "Дачник по имени #{@name} начал работу"
    @plant.grow_all!
  end

  def harvest!
    if @plant.ripe_all?
      @amount_of_harvested_berries += @plant.berries_quantity
      @statistic_of_harvested_berries += @plant.berries_quantity
      @plant.give_away_all!
      print "Дачник по имени #{name} собрал #{@plant.berries_quantity} ягод,\n"\
            "сейчас у него собрано #{@amount_of_harvested_berries} ягод.\n"\
    else
      print "Еще не все ягоды созрели\n"
    end
  end

  def sell_berries!
    if @amount_of_harvested_berries == 0
      puts "У тебя нет ягод в запасе"
      return
    end
    money_to_give = @amount_of_harvested_berries * @@price_per_berry
    @amount_of_harvested_berries = 0
    @money += money_to_give
    puts "Ты продал ягоды за #{money_to_give} монеток"
  end

  def self.knowledge_base
    print "Заметки садовода:\n"\
              "Малину сажать весной, собирать, начиная с середины лета\n"\
              "У ягод есть 3 стадии роста, и её может не быть на кусте\n"
  end
end

if __FILE__ == $PROGRAM_NAME
  # Human.knowledge_base
  # bush = RaspberryBush.new(10)
  # gardener = Human.new('Федя', bush)
  # gardener.work!
  # gardener.harvest!
  # gardener.work!
  # gardener.work!
  # gardener.harvest!

  print "Здравствуй, это же ты хотел поработать на ферме?\n"\
       "Если это так, введи свое имя и начинай работу\n"
  name = gets.chomp
  bush = RaspberryBush.new(10)
  worker = Human.new(name, bush)
  puts Human.knowledge_base
  print "Возможные команды:\n"\
  "0 - ухаживать за кустом малины, 1 - собрать ягоды,\n"\
  "2 - продать ягоды, 3 - баланс игрока, 4 - закончить игру\n"
  loop do
    command = gets.chomp
  loop do
    case command
    when "0"
      worker.work!
    when "1"
      worker.harvest!
    when "2"
      worker.sell_berries!
    when "3"
      puts "#{worker.money} монет при себе"
    when "4"
      break
    else
      puts "Некорректная команда, повтори попытку"
    end
  end
  case worker.statistic_of_harvested_berries
  when 0
    print "Ты позоришь свой народ, не собрав ни одной ягоды\n"
  when 1..10
    print "Ты собрал всего #{worker.statistic_of_harvested_berries} ягод, неплохо для начала\n"
  when 10..50
    print "Хороший старт, #{worker.statistic_of_harvested_berries} ягод не так уж и мало\n"
  when 50..100
    print "Поработал на славу, возвращайся, когда станет скучно\n"
  when 100..500
    puts "Ты вообще человек?!"
  else
    puts "Нет, ты серьезно робот.."
  end
end