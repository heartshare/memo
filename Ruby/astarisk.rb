#!/usr/bin/env ruby

def poo (a, b, c, d)
  p a
  p b
  p c
  p d
end

t  = [1, 2, 3, 4]
tt = [1, 2, 3]

poo(*t)

# 1
# 2
# 3
# 4

poo(*tt, 4)

# 1
# 2
# 3
# 4


# poo(*tt) #引数が足りないのでエラー


def pooo (a, b, c, *d)
  p a
  p b
  p c
  p d
end

pooo(10, 11, 12, 13, 14)

# 10
# 11
# 12
# [13, 14]

ttt = [1, 2, 3, 4, 5]
pooo(*ttt)

# 1
# 2
# 3
# [4, 5]
