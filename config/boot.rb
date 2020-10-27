ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# 将列举在Gemfile里的所有Gem被添加到LOAD_PATH中去 Bundler.setup提供了一个妥协，使得程序可以滞后载入
require 'bundler/setup' # Set up gems listed in the Gemfile.
# require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
