#!/usr/bin/env ruby

class Hage

end

h = Hage.new

p h.instance_of?(Hage)
p h.instance_of?(Object)

p h.kind_of?(Hage)
p h.kind_of?(Object)


# instance_of is not follow subclass


def check( hoge )
  raise "damedame"        unless hoge.kind_of?(Object)
  raise "damedameeeeeeee" unless hoge.kind_of?(Debu)
end

check(h)

