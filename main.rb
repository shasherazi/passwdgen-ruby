#!/usr/bin/env ruby
require 'optparse'

class PasswordGenerator
  def initialize(length, has_numbers: true, has_alphabets: false, has_special_chars: false)
    @length = length
    @has_numbers = has_numbers
    @has_alphabets = has_alphabets
    @has_special_chars = has_special_chars
    @charset = ''
  end

  def build_charset
    @charset += '0123456789' if @has_numbers
    @charset += 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' if @has_alphabets
    @charset += '!@#$%^&*()_+-=[]{};:,./<>?' if @has_special_chars
    @charset
  end

  def print_charset
    puts @charset
  end

  def generate_password
    password = ''
    @length.times do
      password += @charset[rand(@charset.length)]
    end
    password
  end
end

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: main.rb [options]'

  opts.on('-l', '--length [INTEGER]', Integer) do |l|
    options[:length] = l
  end

  opts.on('-n', '--numbers') do
    options[:numbers] = true
  end

  opts.on('-a', '--alphabets') do
    options[:alphabets] = true
  end

  opts.on('-s', '--special-chars') do
    options[:special_chars] = true
  end
end.parse!

password_generator = PasswordGenerator.new(options[:length],
                                           has_numbers: options[:numbers],
                                           has_alphabets: options[:alphabets],
                                           has_special_chars: options[:special_chars])
password_generator.build_charset
puts password_generator.generate_password
