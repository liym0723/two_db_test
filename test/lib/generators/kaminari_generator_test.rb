require 'test_helper'
require 'generators/kaminari/kaminari_generator'

class KaminariGeneratorTest < Rails::Generators::TestCase
  tests KaminariGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
