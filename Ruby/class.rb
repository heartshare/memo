#!/usr/bin/env ruby

class C
  p "self is #{self}"
end

class Up
  def upup( str )
    return str.upcase()
  end
end


# 普通のClass
u = Up.new
puts u.upup("hoge")

class HelloOne
  def initialize( name )
    @bar = name
    puts "hello, #{@bar}"
  end
end

c = HelloOne.new("hoge")
c


# メソッドをいきなり定義しちゃうヤツ
class HelloTwo
  def caaaall=( name )
    @bar = name
    puts "hello, #{@bar}"
  end
end

c = HelloTwo.new
c.caaaall = "hoge"


# 普通のヤツ
class HelloThree
  def initialize( name="soheki")
    @nick = name
    end
  def helohelo
    print "Hello " , @nick, "\n"
  end
end

senno = HelloThree.new
senno.helohelo

onono = HelloThree.new("komachi")
onono.helohelo


# self
class SelfTest
  def prpr( anything )
    self.pypy(anything)
  end

  def pypy( anything )
    p anything
  end
end

SelfTest.new.prpr("pyo")

class SelfTestAnother
  def prpr( anything )
    # self のレシーバなしでイケる
    pypy(anything)
  end

  def pypy( anything )
    p anything
  end
end

SelfTestAnother.new.prpr("pyo")


# instance
class InstanceCheck
  def hoge( yaho )
    @bye = yaho
  end

  def hage
    return @bye
  end
end

i = InstanceCheck.new
i.hoge("hagehage")
p i.hage


# 継承
class A
  def keisho
    return "keshoooo!!!fooo!!!"
  end
end

class B < A
end

a = B.new
p a.keisho


# 変数も継承しちゃう
class A
  def initialize 
    @hoge = "yahooopooo!!!!!!!!"
  end
end

class B < A
  def keikei
    return @hoge
  end
end

a = B.new
p a.keikei



class Hage

end

h = Hage.new

def check( hoge )
  raise "damedame"        unless hoge.kind_of?(Object)
#  raise "damedameeeeeeee" unless hoge.kind_of?(Debu)
end

check(h)



a = 'hoge'

def is_size?( n )
  p n
end

is_size?(a)


