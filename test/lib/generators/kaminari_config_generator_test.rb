require 'test_helper'
require 'generators/kaminari_config/kaminari_config_generator'

class KaminariConfigGeneratorTest < Rails::Generators::TestCase
  tests KaminariConfigGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
