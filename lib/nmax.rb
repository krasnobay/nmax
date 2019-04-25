require 'nmax/version'

# Nmax - search N max values
module Nmax
  class << self
    def call(stream, count)
      list = []
      stream.each_line do |line|
        parse_numbers(line).each do |n|
          next if list.include?(n) || !(list.min.nil? || (n > list.min))

          list << n
          list.delete(list.min) if list.length > count
        end
      end
      list
    end

    private

    def parse_numbers(line)
      line
        .scan(/\d+/)
        .map(&:to_i)
    end
  end
end
