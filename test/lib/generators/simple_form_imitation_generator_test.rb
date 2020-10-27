require 'test_helper'
require 'generators/simple_form_imitation/simple_form_imitation_generator'

class SimpleFormImitationGeneratorTest < Rails::Generators::TestCase
  tests SimpleFormImitationGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
