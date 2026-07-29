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

### Deprecated

### Removed

### Fixed

- kettle-jem-template-20260728-005 - VersionGem bootstrap now creates the
  missing canonical version spec when a project only has shim namespace version
  specs.

### Security

## [2.0.8] - 2026-07-28

- TAG: [v2.0.8][2.0.8t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 100.00% documented

### Fixed

- kettle-jem-template-20260728-004 - Generated dep-heads workflows now use the
  setup-ruby Bundler install path for direct appraisal Gemfiles, avoiding rv
  lockfile parser failures on Git and path dependencies.

## [2.0.7] - 2026-07-28

- TAG: [v2.0.7][2.0.7t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 100.00% documented

### Added

- Documentation linting now has its generated `yard-lint` dependency and severity config available in the local bundle.

- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.

- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.

### Changed

- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.

### Fixed

- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.

- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.

## [2.0.6] - 2026-07-25

- TAG: [v2.0.6][2.0.6t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Changed

- kettle-jem-template-20260725-002 - Generated gemspec templates now include
  `anonymous_loader` as a development dependency, and version specs use it to
  execute generated `version.rb` files for coverage without redefining package
  constants. Managed version specs are removed when `version_gem` is disabled
  or incompatible with the project's runtime Ruby floor.

## [2.0.5] - 2026-07-25

- TAG: [v2.0.5][2.0.5t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Changed

- kettle-jem-template-20260716-001 - Shim gemspec manifests now include
  `LICENSE.md` instead of nonexistent `LICENSE.txt`.
- kettle-jem-template-20260716-002 - Generated gemspec manifests now ship fewer
  repository-only files by default to reduce downstream distro packaging churn.
- kettle-jem-template-20260720-001 - Generated READMEs can now render
  template-managed corporate sponsor logos from project or family config.
- kettle-jem-template-20260720-002 - Generated development Gemfiles now use the
  released `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260720-003 - Generated StructuredMerge Git diff driver
  config now uses the installed `smorg-rb` Ruby driver name.
- kettle-jem-template-20260720-004 - Generated multi-engine workflow files now
  omit JRuby and TruffleRuby jobs when project config declares MRI-only engines.
- kettle-jem-template-20260720-005 - Generated README Support & Community rows
  now include a RubyForum help badge.
- kettle-jem-template-20260725-001 - Generated JRuby and TruffleRuby workflow
  files now run when pull request head branches start with `feature/release`,
  so release CI monitoring does not report intentionally skipped engine
  workflows as failures.

## [2.0.4] - 2026-07-02

- TAG: [v2.0.4][2.0.4t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Fixed

- Package configured license files in gem release file lists.

## [2.0.3] - 2026-06-22

- TAG: [v2.0.3][2.0.3t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Added

- Added support for JRuby 10.1 and TruffleRuby 34.0.

### Changed

- Retemplated project metadata and CI/development automation with `kettle-jem` v7.0.0.

### Fixed

- Corrected RubyGems homepage metadata to point at the gem documentation site.

## [2.0.2] - 2026-06-14

- TAG: [v2.0.2][2.0.2t]
- COVERAGE: 100.00% -- 58/58 lines in 3 files
- BRANCH COVERAGE: 100.00% -- 4/4 branches in 3 files
- 90.00% documented

### Fixed

- Restored `docs/CNAME` so the generated documentation site keeps its custom domain.

### Changed

- Refreshed kettle-jem-managed project files, raising the `kettle-dev`
  development dependency floor to 2.2.9.
- Corrected the kettle-jem template profile from package-only to full
  standalone templating so generated workflows are refreshed by retemplating.

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

[Unreleased]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.8...HEAD
[2.0.8]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.7...v2.0.8
[2.0.8t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.8
[2.0.7]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.6...v2.0.7
[2.0.7t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.7
[2.0.6]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.5...v2.0.6
[2.0.6t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.6
[2.0.5]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.4...v2.0.5
[2.0.5t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.5
[2.0.4]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.3...v2.0.4
[2.0.4t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.4
[2.0.3]: https://github.com/galtzo-floss/gitmoji-regex/compare/v2.0.2...v2.0.3
[2.0.3t]: https://github.com/galtzo-floss/gitmoji-regex/releases/tag/v2.0.3
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
