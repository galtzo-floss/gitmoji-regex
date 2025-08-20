# frozen_string_literal: true

require "singleton"
require "http"
require "json"

# Download the list of all possible gitmojis from the project's github repository
module Gitmoji
  # Namespace for the regex and maintenance tools provided by this gem.
  module Regex
    # Reference provides utility tools for maintaining and testing this gem.
    #
    # It can compare the cached upstream gitmoji list with the latest
    # fetched list, and can regenerate the library source from a template
    # to include an up-to-date regular expression.
    class Reference
      # Remote source of truth for the gitmoji JSON document.
      GITMOJI_REFERENCE = "https://raw.githubusercontent.com/carloscuesta/gitmoji/master/packages/gitmojis/src/gitmojis.json"
      # Path to the cached JSON document bundled in this repository.
      GITMOJI_PATH = "src/gitmojis.json"
      # Path to the library file that contains the REGEX constant.
      LIB_SRC = "lib/gitmoji/regex.rb"
      # Path to the ERB-like template that is used to generate LIB_SRC.
      TEMPLATE_SRC = "src/regex.rb"

      include Singleton

      # Compare the cached JSON-derived regex with the latest fetched regex.
      #
      # @return [Boolean] true if the regex generated from the cached JSON
      #   matches the regex generated from the freshly fetched JSON.
      def compare_json
        return true if cached_pattern == fetched_pattern

        false
      end

      # Regex generated from the cached JSON file.
      # @return [Regexp]
      def cached_pattern
        pattern(cached)
      end

      # Regex generated from the fetched remote JSON.
      # @return [Regexp]
      def fetched_pattern
        pattern(fetch)
      end

      # Compare the current library source with the next generated source.
      #
      # @return [Boolean] true if no changes are needed (files are equal).
      def compare_src
        return true if current_src == next_src

        false
      end

      # Read the current library source file that defines REGEX.
      # @return [String]
      def current_src
        File.read(LIB_SRC)
      end

      # Build the next library source content from the template and fetched data.
      # @return [String] the prospective library source content.
      def next_src
        template_src = File.read(TEMPLATE_SRC)
        template_src = template_src.sub("% gitmojiRegex %", pattern(fetch).to_s)
        template_src.to_s
      end

      # Parse a JSON body and return the list of emoji strings.
      #
      # @param body [String, nil] the JSON document to parse; defaults to cached JSON
      # @return [Array<String>] list of emoji characters
      def to_a(body = nil)
        body ||= cached
        json = JSON.parse(body)
        gitmoji = json["gitmojis"]
        gitmoji.map { |g| g["emoji"] }
      end

      # Write the freshly fetched JSON to the cache file.
      #
      # Also clears memoized cached values.
      # @return [Integer] number of bytes written
      def write_json
        file = File.write(GITMOJI_PATH, fetch)
        @cached = nil
        @cached_pattern = nil
        file
      end

      # Regenerate the library file from the template and fetched data.
      # @return [Integer] number of bytes written
      def write_src
        File.write(LIB_SRC, next_src)
      end

      private

      # Build the union regex from a JSON document body.
      # @param body [String]
      # @return [Regexp]
      def pattern(body)
        Regexp.union(to_a(body))
      end

      # Fetch the latest gitmoji JSON from the remote source.
      # @return [String] the raw response body as a string
      def fetch
        @fetch ||= HTTP.get(GITMOJI_REFERENCE).body
      end

      # Read the cached gitmoji JSON from disk.
      # @return [String]
      def cached
        @cached ||= File.read(GITMOJI_PATH)
      end
    end
  end
end
