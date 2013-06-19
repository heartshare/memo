#!/usr/bin/env ruby

puts "boy meets girl."
puts "boy think so happy!!\n\n"

class Girl
  def initialize (kao, seikaku, taikei)
    @kao     = kao
    @seikaku = seikaku
    @taikei  = taikei
  end
  attr_reader :kao, :seikaku, :taikei
end

girl = Girl.new("kawaii", "tsuntsun", "good")

print "kao     = ", girl.kao , "\n"
print "seikaku = ", girl.seikaku , "\n"
print "taikei  = ", girl.taikei , "\n"


puts "\nAfter a few days..\n\n"

class After_Girl
  def initialize (kao, seikaku, taikei)
    @kao     = kao
    @seikaku = seikaku
    @taikei  = taikei
  end
  attr_accessor :kao, :seikaku, :taikei
end

girl = After_Girl.new("kawaii", "tsuntsun", "good")

girl.kao     = "kawaikunakatta"
girl.seikaku = "yokunakatta"
girl.taikei  = "sorehayokatta"

print "kao     = ", girl.kao, "\n"
print "seikaku = ", girl.seikaku , "\n"
print "taikei  = ", girl.taikei , "\n"

puts "\n\n( '-')..."
