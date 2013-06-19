#!/usr/bin/env ruby

require 'pp'

poem_words = [ 'twinkle', 'littele', 'star' ]

p poem_words

monkey = { 'mizaru' => 'miru', 'kikazaru' => 'kiku', 'iwazaru' => 'iu'}

p monkey
p monkey['mizaru']


name = { first_name: 'unko', last_name: 'taro' }

p name

p name[:first_name]


num = [10, 11, 12]

def pluse ( *args )
  args.each do |arg|
    puts arg
  end
end

pluse(num)

name.each do |key, value|
  puts "#{key} => #{value}"
end


a = [ 1, 2, 3 ]

pp a
pp a.reverse
a.reverse!
pp a


g =  %w{hage hoge mage}
p g

p %q<"hello" World>
p %Q<"hello" World>

