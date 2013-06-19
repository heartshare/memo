#!/usr/bin/env ruby
 
array = []
 
array << [1, 2, 3]
p array # [[1, 2, 3]]
 
array << [4, 5, 6]
p array # [[1, 2, 3], [4, 5, 6]]
 
array = array.flatten
p array # [1, 2, 3, 4, 5, 6]
