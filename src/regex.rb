# frozen_string_literal: true

require "version_gem"

require "gitmoji/regex/version"
require "gitmoji/regex/reference"

module Gitmoji
  # Namespace for all functionality provided by the gitmoji-regex gem.
  module Regex
    # Regular expression that matches any official Gitmoji emoji.
    #
    # You can use this to validate commit messages or extract leading
    # gitmoji from strings.
    #
    # Examples:
    #   # Validate a commit title starts with a gitmoji
    #   (Gitmoji::Regex::REGEX =~ "✨ Add feature") #=> 0
    #
    #   # Extract all gitmojis from text
    #   "✨ Fix bug 🐛".scan(Gitmoji::Regex::REGEX) #=> ["✨", "🐛"]
    REGEX = Regexp.new("% gitmojiRegex %")
  end
end

Gitmoji::Regex::Version.class_eval do
  extend VersionGem::Basic
end
