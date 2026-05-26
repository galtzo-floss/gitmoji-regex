# frozen_string_literal: true

RSpec.describe Gitmoji::Regex::Reference do
  subject(:instance) { described_class.instance }

  let(:known) do
    %w[
      🎨
      ⚡️
      🔥
      🐛
      🚑️
      ✨
      📝
      🚀
      💄
      🎉
      ✅
      🔒️
      🔐
      🔖
      🚨
      🚧
      💚
      ⬇️
      ⬆️
      📌
      👷
      📈
      ♻️
      ➕
      ➖
      🔧
      🔨
      🌐
      ✏️
      💩
      ⏪️
      🔀
      📦️
      👽️
      🚚
      📄
      💥
      🍱
      ♿️
      💡
      🍻
      💬
      🗃️
      🔊
      🔇
      👥
      🚸
      🏗️
      📱
      🤡
      🥚
      🙈
      📸
      ⚗️
      🔍️
      🏷️
      🌱
      🚩
      🥅
      💫
      🗑️
      🛂
      🩹
      🧐
      ⚰️
      🧪
      👔
      🩺
      🧱
      🧑‍💻
      💸
      🧵
      🦺
      ✈️
      🦖
    ]
  end

  it "Cached reference has no missing gitmoji" do
    expect(instance.to_a - known).to eq([])
  end

  describe "#compare_src" do
    it "Cached source is current" do
      expect(instance.compare_src).to be(true)
    end

    it "detects change" do
      allow(File).to receive(:read).and_return("a", "b")
      expect(instance.compare_src).to be(false)
    end

    it "reads files" do
      allow(File).to receive(:read).and_return("a", "b")
      instance.compare_src
      expect(File).to have_received(:read).twice
    end
  end

  it "Cached source is current" do
    expect(instance.current_src).to eq(instance.next_src)
  end

  it "Cached pattern is current" do
    skip "JRuby HTTP can fail to read GitHub response headers in CI" if RUBY_ENGINE == "jruby"

    expect(instance.cached_pattern).to eq(instance.fetched_pattern)
  end

  describe "#compare_json" do
    it "Cached reference is current" do
      expect(instance.compare_json).to be(true)
    end

    it "detects change" do
      allow(Regexp).to receive(:union).and_return("a", "b")
      expect(instance.compare_json).to be(false)
    end

    it "calls pattern" do
      allow(Regexp).to receive(:union).and_return("a", "b")
      instance.compare_json
      expect(Regexp).to have_received(:union).twice
    end
  end

  describe "#write_json" do
    it "writes" do
      allow(File).to receive(:write).with(described_class::GITMOJI_PATH, anything)
      instance.write_json
      expect(File).to have_received(:write)
    end
  end

  describe "#write_src" do
    it "writes" do
      allow(File).to receive(:write).with(described_class::LIB_SRC, anything)
      instance.write_src
      expect(File).to have_received(:write)
    end
  end
end
