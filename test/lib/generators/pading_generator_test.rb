require 'test_helper'
require 'generators/pading/pading_generator'

class PadingGeneratorTest < Rails::Generators::TestCase
  tests PadingGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
