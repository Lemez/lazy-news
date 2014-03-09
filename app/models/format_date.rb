class String

 def self.format_date
    i = self.index("'")
    new_self = self[0...i] + '20' + self[i+1..-1]
    return new_self
  end

end
