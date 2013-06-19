#!/usr/bin/env ruby

# ==================================================

hoge = "hello"
hage = "hello"

a = hoge if hage
p a

b = hoge unless hage
p b 

hoges = [ 'a', 'b', 'c' ]

hoges.each do |h|
  puts h
end

# =================================================

class H
  def check( people ) 
     real = case people
       when 'hage' then 'your hage'
       when 'debu' then 'your debu'
       else 'your smart'
       end

     return real

  end
end

h = H.new
ahos = [ 'hage', 'debu', 'unko' ]

ahos.each do |aho|
  answer = h.check(aho)
  p answer
end

# ==============================

class Hooo
  def hooo( name )
    case name
    when /Hom/
      puts 'HomHom'
    when /Hon/
      puts 'HonHon'
    when /H/
      puts 'H'
    else
      puts 'hoge'
    end
  end
end

h = Hooo.new
homs = [ "H", 'Hom', 'Honn' ]

homs.each do |hom|
  p hom
  h.hooo(hom)
end
