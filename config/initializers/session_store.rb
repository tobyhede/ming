# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MongoR_session',
  :secret      => '00176ff62c906bfcd20c3008aae8301c9a578fa13fa0444751556d2ed6fd7679961a4155a6c8b3ddf76d1adb4a0e51acdea6d483e732410895fa510b9b2e96d8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
