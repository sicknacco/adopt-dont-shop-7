def test_data
  @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
  @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

  @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
  @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')

  @pet_3 = @shelter_2.pets.create!(adoptable: true, age: 2, breed: 'saint bernard', name: 'Beethoven')
  @pet_4 = @shelter_2.pets.create!(adoptable: false, age: 8, breed: 'border collie', name: 'Marshall')
  @pet_5 = @shelter_2.pets.create!(adoptable: true, age: 4, breed: 'tabby', name: 'Pepper')

  @application_1 = Application.create!(name: 'Bob', street_address: '1234 Southeast St',
    city: 'San Francisco', state: 'CA', zip_code: 12345,
    description: 'Wants a dog', pets: 'Lobster', status: 'Pending')
  @application_2 = Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
    city: 'San Francisco', state: 'CA', zip_code: 54321,
    description: 'Would like a siamese cat', pets: 'Lucille Bald', status: 'In Progress')

  @application_3 = Application.create!(name: 'Fred', street_address: '376 Monroe St',
    city: 'Los Angeles', state: 'CA', zip_code: 67890,
    description: 'My wife really wants this cat', pets: 'Pepper', status: 'In Progress')
  @application_4 = Application.create!(name: 'Toki', street_address: '8395 Other St',
    city: 'Los Somewhere', state: 'ZX', zip_code: 37163,
    description: 'We want this cat more than Fred', pets: 'Pepper', status: 'In Progress')
  @application_5 = Application.create!(name: 'Jimbo', street_address: '45865 Turnaround St',
    city: 'NYC', state: 'NY', zip_code: 84930,
    description: 'I want a big ol dog', pets: 'Beethoven', status: 'In Progress')

  PetApplication.create!(pet: @pet_1 application: @application_2)
  PetApplication.create!(pet: @pet_2 application: @application_1)

  PetApplication.create!(pet: @pet_3 application: @application_5)
  PetApplication.create!(pet: @pet_5 application: @application_3)
  PetApplication.create!(pet: @pet_5 application: @application_4)
end



require "simplecov"
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end