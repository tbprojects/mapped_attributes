ENV['RAILS_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'

require 'rails/all'
require File.expand_path('../rails_app/config/environment.rb', __FILE__)

SPEC_ROOT = Pathname.new(File.expand_path('../', __FILE__))
Dir[SPEC_ROOT.join('support/*.rb')].each{|f| require f }

require File.expand_path('../../lib/mapped_attributes.rb', __FILE__)