# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

### Changed

- Refreshed kettle-jem-managed project files, raising the `kettle-dev`
  development dependency floor to 2.2.9.

### Deprecated

### Removed

### Fixed

### Security

## [2.0.2] - 2026-06-14

- TAG: [v2.0.2][2.0.2t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Fixed

- Restored `docs/CNAME` so the generated documentation site keeps its custom domain.

## [2.0.1] - 2026-05-31

- TAG: [v2.0.1][2.0.1t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Changed

- Refreshed kettle-jem-managed project files, including StructuredMerge git
  driver configuration, local development dependency wiring, and README/Rakefile
  template updates.

### Fixed

- Fixed generated documentation URLs that incorrectly pointed at a monorepo
  `gems/gitmoji-regex` path.

## [2.0.0] - 2026-05-26

- TAG: [v2.0.0][2.0.0t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Added

- New gitmoji "🦖" (`:t-rex:`) for code that adds backwards compatibility

### Changed

- Documented the `bin/refresh` maintainer workflow for syncing the upstream gitmoji reference

### Removed

- Support for Ruby 2.3

## [1.0.3] - 2025-08-20

- TAG: [v1.0.3][1.0.3t]
- COVERAGE: 100.00% -- 57/57 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 100.00% documented

### Added

- New gitmoji "✈️"
- appraisal2 for improved testing platform coverage in CI

### Changed

- gem dependencies for local development
- centralized logos to logos.galtzo.com
- scripts to enforce git commit message style

## [1.0.2] - 2023-05-30

- TAG: [v1.0.2][1.0.2t]

### Added

- New gitmoji "🧵"
- New gitmoji "🦺"
- Releases are now signed
- Releases now include SHA256 and SHA512 checksums

### Fixed

- 100% branch & line test coverage

### Changed

- Primary source forge moved from GitHub to [Source Hut](https://git.sr.ht/~galtzo/gitmoji-regex)

## [1.0.1] - 2022-06-24

### Added

- bin stubs for development
- Improved contributing guidelines

### Fixed

- Updated Template `src/regex.rb`
- CI Build improvements

## [1.0.0] - 2022-06-24

### Added

- New gitmoji "💸"
- Gitmoji::Regex::Version is introspectable

### Changed

- Gitmoji::Regex::VERSION is now Gitmoji::Regex::Version::VERSION

## [0.1.3] - 2022-03-30

### Added

- Documentation
- Badges

### Fixed

- Code Coverage
- Changelog URLs

## [0.1.2] - 2022-03-29

### Added

- Badges and Logos

## [0.1.1] - 2022-03-28

### Added

- Usage documentation

## [0.1.0] - 2022-03-28

### Added

- Initial release

[Unreleased]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.2...HEAD
[2.0.2]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.1...v2.0.2
[2.0.2t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.2
[2.0.1]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.0...v2.0.1
[2.0.1t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.1
[2.0.0]: https://github.com/galtzo-floss/gitmoji-regex/compare/v1.0.3...v2.0.0
[2.0.0t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.0
[1.0.4]: https://github.com/galtzo-floss/gitmoji-regex/compare/v1.0.3...v1.0.4
[1.0.4t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v1.0.4
[1.0.3]: https://github.com/galtzo-floss/gitmoji-regex/compare/v1.0.2...v1.0.3
[1.0.3t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v1.0.3
[1.0.2]: https://github.com/galtzo-floss/gitmoji-regex/compare/v1.0.1...v1.0.2
[1.0.2t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v1.0.2
[1.0.1]: https://github.com/galtzo-floss/gitmoji-regex/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/galtzo-floss/gitmoji-regex/compare/v0.1.3...v1.0.0
[0.1.3]: https://github.com/galtzo-floss/gitmoji-regex/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/galtzo-floss/gitmoji-regex/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/galtzo-floss/gitmoji-regex/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/galtzo-floss/gitmoji-regex/compare/e71c6c3dad5bfd59ae2509531eaea3a16e21cb63...v0.1.0
