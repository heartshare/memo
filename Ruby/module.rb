#!/usr/bin/env ruby


module UP
  def upup( hoge )
    return hoge.upcase
  end
end

class A
  include UP
end

a = A.new
p a.upup("hello world.")

module M
  def m
    puts "heyhey m"
  end
end

module MM
  include M

  def mm
    puts "heyhey mm"
  end
end

module MMM
  include MM

  def mmm
    puts "heyhey mmm"
  end
end

class Mmmm
  include MMM
end

m = Mmmm.new

m.m
m.mm
m.mmm
