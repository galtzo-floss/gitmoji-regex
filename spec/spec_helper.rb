# frozen_string_literal: true

DEBUGGING = ENV.fetch("DEBUG", "false").casecmp("true").zero?
DEBUG_IDE = ENV.fetch("DEBUG_IDE", "false").casecmp("true").zero?

# External gems
require "debug" if DEBUGGING
require "silent_stream"
require "rspec/block_is_expected"
require "rspec/block_is_expected/matchers/not"
require "rspec/stubbed_env"
require "version_gem/ruby"
require "version_gem/rspec"

IS_CI = ENV.fetch("CI", "false").casecmp("true") == 0

# RSpec Configs
require "config/rspec/rspec_core"
require "config/rspec/rspec_block_is_expected"
require "config/debug"

# Within the test suite, we will consider this gem to be activated
ENV["FLOSS_FUNDING_GITMOJI__REGEX"] = "Free-as-in-beer"

# NOTE: Gemfiles for older rubies won't have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
rescue LoadError => error
  # check the error message and re-raise when unexpected
  raise error unless error.message.include?("kettle")
end

# This gem
require "gitmoji/regex"

# Not required by default, as it is not part of the gem's API, primarily for specs and maintainers
require "gitmoji/regex/reference"

GITMOJI_REF = Gitmoji::Regex::Reference.instance
