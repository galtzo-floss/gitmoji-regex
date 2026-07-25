# frozen_string_literal: true

require "anonymous_loader"
RSpec.describe Gitmoji::Regex::Version do
  it_behaves_like "a Version module", described_class

  it "executes the version file for coverage without redefining constants" do
    path = File.expand_path("../../../lib/gitmoji/regex/version.rb", __dir__)
    anonymous_namespace = AnonymousLoader.load(files: path)

    expect(anonymous_namespace::Gitmoji::Regex::Version::VERSION).to eq(described_class::VERSION)
  end
end
