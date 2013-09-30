# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
TeamNote::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || 'd27d35a9e25724ecb3b50280d9163065320e11d21fd3246f7b35cda2ac6210bf0a2ff77bf94e9742d26b9bfff33dbaef1281c5af8cdac4e1e59b721fa78be265'
