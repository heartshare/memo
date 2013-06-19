#!/usr/bin/env ruby

puts "a ball, and a sky".sub('a ','the ')
puts "a ball, and a sky".gsub('a ','the ')

puts "a ball, and a sky".sub(/\s/,'_')
puts "a ball, and a sky".gsub(/\s/,'_')
