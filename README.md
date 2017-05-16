# RubyDesignPatternsInPractice

## Table of Contents

  1. [Adapter](#adapter)
  1. [Builder](#builder)
  1. [Command](#command)
  1. [Composite](#composite)
  1. [Decorator](#decorator)
  1. [Facade](#facade)
  1. [Factory](#factory)
  1. [Interpreter](#interpreter)
  1. [Iterator](#iterator)
  1. [Observer](#observer)
  1. [Proxy](#proxy)
  1. [Singleton](#singleton)
  1. [State](#state)
  1. [Strategy](#strategy)
  1. [Template](#template)

## Adapter
  - Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces.<sup>[[link](#adapter)]</sup>

  ```ruby
  class Quest
    attr_accessor :difficulty, :hero

    def initialize(difficulty)
      @difficulty = difficulty
      @hero = nil
    end

    def finish
      @hero.exp += calculate_experience
    end

    def calculate_experience
      @difficulty * 50 / @hero.level
    end
  end

  class Hero
    attr_accessor :level, :exp, :quests

    def initialize
      @level = 1
      @exp = 0
      @quests = []
    end

    def take_quest(quest)
      @quests << (quest.hero = self)
    end

    def finish_quest(quest)
      quest.finish
      @quests.delete quest
    end
  end

  class OldQuest
    attr_accessor :hero, :difficulty, :experience

    def initialize
      @difficulty = 3
      @experience = 10
    end

    def done
      difficulty * experience
    end
  end

  class QuestAdapter
    attr_accessor :hero

    def initialize(old_quest, difficulty)
      @old_quest = old_quest
      @old_quest.difficulty = difficulty
      @hero = nil
    end

    def finish
      @hero.exp += @old_quest.done
    end
  end

  # Usage
  hero = Hero.new
  quest = Quest.new 5
  hero.take_quest quest
  hero.finish_quest quest
  puts hero.exp
  # => 250
  some_old_quest = OldQuest.new
  old_quest_adapted = QuestAdapter.new(some_old_quest, 5)
  hero.take_quest old_quest_adapted
  hero.finish_quest old_quest_adapted
  puts hero.exp
  # => 300
  ```

**[Back to top](#table-of-contents)**

## Builder
  - Separate the construction of a complex object from its representation so that the same construction process can create different representations.<sup>[[link](#builder)]</sup>

  ```ruby
  class BoardBuilder
    def initialize(width, height)
      @board = Board.new
      @board.width = width
      @board.height = height
      @board.tiles = []
      @board.monsters = []
    end

    def add_tiles(n)
      n.times{ @board.tiles << Tile.new }
    end

    def add_monsters(n)
      n.times{ @board.monsters << Monster.new }
    end

    def board
      @board
    end
  end

  class Board
    attr_accessor :width, :height, :tiles, :monsters
    def initialize
    end
  end

  class Tile; end
  class Monster; end

  # Usage
  builder = BoardBuilder.new 2, 3
  puts builder.board
  # => Board Object
  board = builder.board
  puts board.width
  # => 2
  builder.add_tiles(3)
  builder.add_monsters(2)
  puts board.tiles.size
  # => 3
  puts board.monsters.size
  # => 2
  ```

**[Back to top](#table-of-contents)**

## Command
  - Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.<sup>[[link](#command)]</sup>

  ```ruby
  class Turn
    def initialize
      @commands = []
    end

    def run_command(command)
      command.execute
      @commands << command
    end

    def undo_command
      @commands.pop.unexecute
    end
  end

  class Hero
    attr_accessor :money, :health

    def initialize
      @money = 0
      @health = 100
    end
  end

  class GetMoneyCommand
    def initialize(hero)
      @hero = hero
    end

    def execute
      @hero.money += 10
    end

    def unexecute
      @hero.money -= 10
    end
  end

  class HealCommand
    def initialize(hero)
      @hero = hero
    end

    def execute
      @hero.health += 10
    end

    def unexecute
      @hero.health -= 10
    end
  end

  # Usage
  hero = Hero.new
  get_money = GetMoneyCommand.new hero
  heal = HealCommand.new hero
  turn = Turn.new
  turn.run_command(heal)
  puts hero.health
  # => 110
  turn.run_command(get_money)
  puts hero.money
  # => 10
  turn.undo_command
  puts hero.money
  # => 0
  ```

**[Back to top](#table-of-contents)**

## Composite
  - Composition over inheritance. Compose objects into tree structures to represent part-whole hierarchies.<sup>[[link](#composite)]</sup>

  ```ruby
  class CompositeQuest
    def initialize
      @tasks = []
    end

    def <<(task)
      @tasks << task
    end

    def reward
      @tasks.inject(0){ |sum, task| sum += task.reward }
    end
  end

  class MegaQuest < CompositeQuest
  end

  class Quest < CompositeQuest
  end

  class MonsterTask
    attr_reader :reward

    def initialize
      @reward = 100
    end
  end

  class PuzzleTask
    attr_reader :reward

    def initialize
      @reward = 200
    end
  end

  # Usage
  quest1 = Quest.new
  quest1 << MonsterTask.new
  quest1 << PuzzleTask.new
  puts quest1.reward
  # => 300

  quest2 = Quest.new
  quest2 << MonsterTask.new
  quest2 << PuzzleTask.new
  megaquest = MegaQuest.new
  megaquest << quest1
  megaquest << quest2
  puts megaquest.reward
  # => 600
  ```

**[Back to top](#table-of-contents)**

## Decorator
  - Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.<sup>[[link](#decorator)]</sup>

  ```ruby
  class ItemDecorator
    def initialize(item)
      @item = item
    end
    # this needs to be delegated with other efective way
    def use
      @item.use
    end
  end

  class MagicItemDecorator < ItemDecorator
    def price
      @item.price * 3
    end

    def description
      @item.description + "Magic"
    end
  end

  class MasterpieceItemDecorator < ItemDecorator
    def price
      @item.price * 2
    end

    def description
      @item.description + "Masterpiece"
    end
  end

  class Item
    attr_reader :price, :description
    def initialize
      @price = 10
      @description = "Item "
    end

    def use
      "do something"
    end
  end

  # Usage
  item = Item.new
  magic_item = MagicItemDecorator.new(item)
  puts magic_item.price
  # => 30
  puts magic_item.description
  # => Item Magic

  masterpiece_item = MasterpieceItemDecorator.new(item)
  puts masterpiece_item.price
  # => 20
  puts masterpiece_item.description
  # => Item Masterpiece

  # all next lines puts "do something"
  item.use
  magic_item.use
  masterpiece_item.use
  ```

**[Back to top](#table-of-contents)**

## Facade
  - The goal of the Facade Pattern is to provide a unified interface to a set of interfaces in a subsystem. This means you'd just have some object that can send back other objects.<sup>[[link](#facade)]</sup>

  ```ruby
  class Hero
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def join(level)
      puts "#{self.name} join #{level}\n"
    end

    def attack(enemy)
      puts "#{self.name} kick #{enemy}\n"
    end
  end

  class Enemy
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def dead(hero)
      puts "#{self.name} killed by #{hero}"
    end
  end

  class Level
    attr_reader :stage

    def initialize(stage)
      @stage = stage
    end

    def to_s
      stage
    end
  end

  class GameFacade
    attr_reader :hero, :enemy, :level

    def initialize
      @hero  = Hero.new('Sonic')
      @enemy = Enemy.new('Eggman')
      @level = Level.new('Green Hill')
    end

    def start_game
      hero.join(level)
      hero.attack(enemy.name)
      enemy.dead(hero.name)
    end
  end

  game = GameFacade.new
  game.start_game
  # => Sonic join Green Hill
  #    Sonic kick Eggman
  #    Eggman killed by Sonic
  ```

**[Back to top](#table-of-contents)**

## Factory
  - Define an interface for creating an object, but let subclasses decide which class to instantiate.<sup>[[link](#factory)]</sup>

  ```ruby
  class Party
    attr_reader :members
    def initialize(factory)
      @members = []
      @factory = factory
    end

    def add_warriors(n)
      n.times{ @members << @factory.create_warrior }
    end

    def add_mages(n)
      n.times{ @members << @factory.create_mage }
    end
  end

  class HeroFactory
    def create_warrior
      Warrior.new
    end

    def create_mage
      Mage.new
    end
  end

  class Hero
    def initialize
    end
  end

  class Warrior < Hero
  end

  class Mage < Hero
  end

  # Usage
  party = Party.new(HeroFactory.new)
  party.add_warriors(3)
  party.add_mages(2)
  puts party.members.size
  # => 5
  puts party.members.count{ |member| member.class == "Mage" }
  # => 2
  ```

**[Back to top](#table-of-contents)**

## Interpreter
  - This pattern provides an interpreter to deal with an abstract language. Using classes we can understand the inputs for parse them.<sup>[[link](#interpreter)]</sup>

  ```ruby
  class Word
    def initialize(value)
      @value = value
    end

    def execute
      @value
    end
  end

  class Plus
    def initialize(first, second)
      @first = first
      @second = second
    end

    def execute
      @first.execute + @second.execute
    end
  end

  class Minus
    def initialize(first, second)
      @first = first
      @second = second
    end

    def execute
      index = @first.execute =~ /#{@second.execute}/
      second_index = index + @second.execute.length
      @first.execute[0,index] + @first.execute[second_index..-1]
    end
  end

  class Interpreter
    def self.parse(input)
      @waiting_second_word = false
      words = []
      operations = []
      input.split.each_with_index do |value|
        if value =~ /^[^+-].*/ && !@waiting_second_word
          words << Word.new(value)
        else
          if symbol = operations.pop()
            first = words.size > 1 ? Word.new(words.map(&:execute).join(" ")) :
              words.pop
            second = Word.new(value)
            case symbol
            when /\A\+/
              words << Word.new(Plus.new(first, second).execute)
            when /\A\-/
              words << Word.new(Minus.new(first, second).execute)
            end
            @waiting_second_word = false
          else
            @waiting_second_word = true
            operations << value
          end
        end
      end
      words.pop.execute
    end
  end

  puts Interpreter.parse("NA + NA + NA + BATMAN")
  #=> NANANABATMAN

  puts Interpreter.parse("you know nothing Jon Snow - nothing")
  #=> you know Jon Snow

  puts Interpreter.parse("hello + world - llowo")
  #=>herld
  ```

**[Back to top](#table-of-contents)**

## Iterator
  - Iterator helps you to iterate through a complex object using an iterator method.<sup>[[link](#iterator)]</sup>

  ```ruby
  class Parent
    attr_reader :first_name

    def initialize(first_name, gender)
      @first_name = first_name
      @gender = gender
    end
  end

  class Child < Parent
  end

  class Family
    def initialize(surname)
      @surname = surname
      @children = []
    end

    def add_father(first_name)
      @father = Parent.new first_name, "M"
    end

    def add_mother(first_name)
      @mother = Parent.new first_name, "F"
    end

    def add_child(first_name, gender)
      @children << Child.new(first_name, gender)
    end

    def each_member
      [@father, @mother, @children].flatten.each do |member|
        yield member
      end
    end
  end

  # Usage
  family = Family.new "Jackson"
  family.add_father("Robert")
  family.add_mother("Susan")
  family.add_child("Lucas", "M")
  family.add_child("James", "M")
  family.add_child("Rose", "F")
  family.each_member{ |member| puts member.first_name }
  # => Robert
  #    Susan
  #    Lucas
  #    James
  #    Rose
  ```

**[Back to top](#table-of-contents)**

## Observer
  - Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.<sup>[[link](#observer)]</sup>

  ```ruby
  module Observable
    attr_reader :observers

    def initialize(attrs = {})
      @observers = []
    end

    def add_observer(observer)
      @observers << observer
    end

    def notify_observers
      @observers.each{ |observer| observer.update }
    end
  end

  class Tile
    include Observable

    def initialize(attrs = {})
      super
      @cursed = attrs.fetch(:cursed, false)
    end

    def cursed?
      @cursed
    end

    def activate_curse
      notify_observers
    end
  end

  class Hero
    attr_reader :health

    def initialize
      @cursed = false
      @health = 10
    end

    def damage(hit)
      @health -= hit
    end

    def cursed?
      @cursed
    end

    def discover(tile)
      if tile.cursed?
        @cursed = true
        tile.add_observer(self)
      end
    end

    def update
      damage(4)
    end
  end

  # Usage
  hero = Hero.new
  tile = Tile.new cursed: true
  hero.discover(tile)
  tile.activate_curse
  puts hero.health
  # => 6
  puts hero.cursed?
  # => true
  ```

**[Back to top](#table-of-contents)**

## Proxy
  - Provide a surrogate or placeholder for another object to control access to it.<sup>[[link](#proxy)]</sup>

  ```ruby
  require 'forwardable'

  class Hero
    attr_accessor :keywords

    def initialize
      @keywords = []
    end
  end

  class ComputerProxy
    # Forwardable allows objects to run methods on behalf
    # of it's members, in this case the Computer object
    extend Forwardable

    # We delegate the ComputerProxy's use of
    # the Computer object's add method
    def_delegators :real_object, :add

    def initialize(hero)
      @hero = hero
    end

    def execute
      check_access
      real_object.execute
    end

    def check_access
      unless @hero.keywords.include?(:computer)
        raise "You have no access"
      end
    end

    def real_object
      @real_object ||= Computer.new
    end
  end

  class Computer
    def initialize
      @queue = []
    end

    def add(command)
      @queue << command
    end

    def execute
      "executing commands"
    end
  end

  # Usage
  hero = Hero.new
  proxy = ComputerProxy.new(hero)
  proxy.add("some command")
  proxy.execute
  # => raise error
  hero.keywords << :computer
  proxy.execute
  # => executing commands
  ```

**[Back to top](#table-of-contents)**

## Singleton
  - Define a unique instance of an object.<sup>[[link](#singleton)]</sup>

  ```ruby
  class HeroFactory
    @@instance = nil

    def self.instance
      @@instance ||= HeroFactory.send(:new)
    end

    def create_warrior
      Warrior.new
    end

    def create_mage
      Mage.new
    end

    private_class_method :new
  end

  # Usage
  factory = HeroFactory.instance
  another_factory = HeroFactory.instance
  puts factory == another_factory
  # => true
  HeroFactory.new
  # => Raise Exception
  ```

**[Back to top](#table-of-contents)**

## State
  - This pattern tries to simplify complicated control flows changing an object's behavior dynamically.<sup>[[link](#state)]</sup>

  ```ruby
  class Operation
    attr_reader :state
    def initialize
      @state = OperationOpenState.new
    end

    def trigger(state)
      @state = @state.next(state)
    end
  end

  class OperationOpenState
    def next(state)
      if valid?(state)
        OperationPendingPaymentState.new
      else
        raise IllegalStateJumpError
      end
    end

    def valid?(state)
      state == :pending_payment
    end
  end

  class OperationPendingPaymentState
    def next(state)
      OperationConfirmState.new if valid?(state)
    end

    def valid?(state)
      state == :confirm
    end
  end
  class IllegalStateJumpError < StandardError; end
  class OperationConfirmState; end

  #Usage
  operation = Operation.new
  puts operation.state.class
  #=> OperationOpenState
  operation.trigger :pending_payment
  puts operation.state.class
  #=> OperationPendingPaymentState
  operation.trigger :confirm
  puts operation.state.class
  #=> OperationConfirmState

  operation = Operation.new
  operation.trigger :confirm
  #=> raise IllegalStateJumpError
  ```

**[Back to top](#table-of-contents)**

## Strategy
  - Define a family of algorithms, encapsulate each one, and make them interchangeable.<sup>[[link](#strategy)]</sup>

  ```ruby
  class Hero
    attr_reader :damage, :health, :skills
    attr_accessor :printer

    def initialize(printer)
      @damage = 10
      @health = 5
      @printer = printer
      @skills = [:stealth, :driving, :intimidation]
    end

    def print_stats
      if block_given?
        yield(damage, health, skills)
      else
        printer.print(damage, health, skills)
      end
    end
  end

  class BattleStats
    def print(damage, health, skills)
      "Damage: #{damage}\nHealth: #{health}"
    end
  end

  class SkillStats
    def print(damage, health, skills)
      skills.inject(""){ |result, skill| result + skill.to_s.capitalize + "\n" }
    end
  end

  # Usage
  Hero.new(BattleStats.new).print_stats
  # => Damage: 10
  #    Health: 5

  Hero.new(SkillStats.new).print_stats
  # => Stealth
  #    Driving
  #    Intimidation

  Hero.new(any_printer).print_stats do |damage, health, skills|
    "Looks: I'm printing a customize message about my hero with damage #{damage} and number of skills: #{skills.size}"
  end
  ```

**[Back to top](#table-of-contents)**

## Template
  - Define the skeleton of an algorithm in an operation, deferring some steps to subclasses. Template methods lets subclasses redefine certain steps of an algorithm without changing the algorithm's structure.<sup>[[link](#template)]</sup>

  ```ruby
  class Hero
    attr_reader :damage, :abilities

    def initialize
      @damage = damage_rating
      @abilities = occupation_abilities
    end

    def greet
      greeting = ["Hello"]
      greeting << unique_greeting_line
      greeting
    end

    def unique_greeting_line
      raise "You must define unique_greeting_line"
    end

    def damage_rating
      10
    end

    def occupation_abilities
      []
    end

    def attack
      "Atack dealing #{damage} damage"
    end
  end

  class Warrior < Hero
    def damage_rating
      15
    end

    def occupation_abilities
      [:strike]
    end

    def unique_greeting_line
      "Warrior is ready to fight!"
    end
  end

  class Mage < Hero
    def damage_rating
      7
    end

    def occupation_abilities
      [:magic_spell]
    end

    def unique_greeting_line
      "Mage is ready to make powerful spells!"
    end
  end
  ```

**[Back to top](#table-of-contents)**