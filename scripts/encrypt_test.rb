$LOAD_PATH << '.'
require 'encryption.rb'
include Encryption
require 'openssl'

# Formatting
line_break = "-----------------------------------------------------------------"

# Set variables
@public_key = OpenSSL::PKey::RSA.new(File.read('public.pem'))
puts "Public RSA key loaded"

@signed_nonce = ENV["SIGNED_NONCE"]
if @signed_nonce.nil?
	puts "please set SIGNED_NONCE"
else
	puts "Signed nonce loaded"
end

@private_key = ENV["PRIVATE_KEY"]
if @private_key.nil?
	puts "Please set PRIVATE_KEY"
else
	puts "Private key loaded"
end

## Use private_key decrypt signed_nonce
@nonce = Encryption.decrypt(@private_key, @signed_nonce)
puts "Valid RSA key."

## Re-Encrypt with public_key

@encrypted_nonce = Encryption.pub_encrypt(@nonce)
puts "NONCE:"
puts @nonce
puts line_break
puts

puts "ENCRYPTED NONCE:"
p @encrypted_nonce
puts line_break
puts

@signature = Encryption.private_sign(@nonce)
puts " PRIVATE KEY SIGNATURE:"
puts @signature
puts

# puts Encryption.verify_sign(@nonce, ENV["SIGNATURE"])
puts "**Valid  Key Signature?**"
if ENV["SIGNATURE"] == @signature.chomp
	puts "Valid, Key signatures match."
else
	puts "Invalid"
end