#!/usr/bin/env ruby
require 'slop'

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

options = Slop.parse do |o|
  o.banner = "passwdgen is a simple password generator\n\nUsage: passwdgen [options]\n"
  o.integer '-l', '--length', 'Length of password', default: 16
  o.bool '-n', '--numbers', 'Include numbers in password'
  o.bool '-a', '--alphabets', 'Include alphabets in password', default: true
  o.bool '-s', '--special-chars', 'Include special characters in password'

  o.on '-h', '--help' do
    puts o
    exit
  end
end

password_generator = PasswordGenerator.new(options[:length],
                                           has_numbers: options[:numbers],
                                           has_alphabets: options[:alphabets],
                                           has_special_chars: options[:special_chars])
password_generator.build_charset
puts password_generator.generate_password
