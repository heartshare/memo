#!/usr/bin/env ruby

a = true ?\
  "a" : "b"
p a # "a"

b = true ?
  "a" : "b"
p b # ""
