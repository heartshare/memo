#!/usr/bin/env ruby

n = [10, 20, 30]

p n.map {|a| a + 1}
p n.collect {|a| a + 1}

p n.inject {|a,b| a + b}
p n.reduce {|a,b| a + b}
