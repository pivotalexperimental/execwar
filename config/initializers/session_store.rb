# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_execwar_session',
  :secret      => 'fdd8527d66c7fdfbc933ff532c0a76bdb87f7b10be9a97d038be31a025a40a4efa9caad5916f977d4c26d9b15e3b8db7f8736a9a86addc258e27222135ea09d7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
