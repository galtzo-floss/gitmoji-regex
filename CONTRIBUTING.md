# Contributing

Bug reports and pull requests are welcome on GitHub, CodeBerg, or [GitLab][🚎src-main].
This project should be a safe, welcoming space for collaboration, so contributors agree to adhere to
the [code of conduct][🤝conduct].

To submit a patch, please fork the project, create a patch with tests, and send a pull request.

Remember to [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog].

## Help out!

Take a look at the `reek` list which is the file called `REEK` and find something to improve.

Follow these instructions:

1. Fork the repository
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Make some fixes.
4. Commit changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Make sure to add tests for it. This is important, so it doesn't break in a future release.
7. Create new Pull Request.

## Appraisals

From time to time the Appraisal2 gemfiles in `gemfiles/` will need to be updated.
They are created and updated with the commands:

```console
bin/rake appraisal:update
```

When adding an appraisal to CI check the [runner tool cache][🏃‍♂️runner-tool-cache] to see which runner to use.

## Refresh Gitmoji Reference

When the upstream gitmoji catalog changes, refresh the vendored reference and regenerate the regex with:

```console
bin/refresh
```

This script fetches `Gitmoji::Regex::Reference::GITMOJI_REFERENCE`, updates `src/gitmojis.json`,
and rewrites `lib/gitmoji/regex.rb` from `src/regex.rb`.

After running it:

1. Review the diff in `src/gitmojis.json` and `lib/gitmoji/regex.rb`
2. Run `bin/rake`
3. Add a note to `CHANGELOG.md` for any newly added upstream gitmoji

## The Reek List

Take a look at the `reek` list which is the file called `REEK` and find something to improve.

To refresh the `reek` list:

```console
bundle exec reek > REEK
```

## Run Tests

To run all tests

```console
bundle exec rake test
```

## Lint It

Run all the default tasks, which includes running the gradually autocorrecting linter, `rubocop-gradual`.

```console
bundle exec rake
```

Or just run the linter.

```console
bundle exec rake rubocop_gradual:autocorrect
```

For more detailed information about using RuboCop in this project, please see the [RUBOCOP.md](RUBOCOP.md) guide. This project uses `rubocop_gradual` instead of vanilla RuboCop, which requires specific commands for checking violations.

### Important: Do not add inline RuboCop disables

Never add `# rubocop:disable ...` / `# rubocop:enable ...` comments to code or specs (except when following the few existing `rubocop:disable` patterns for a rule already being disabled elsewhere in the code). Instead:

- Prefer configuration-based exclusions when a rule should not apply to certain paths or files (e.g., via `.rubocop.yml`).
- When a violation is temporary and you plan to fix it later, record it in `.rubocop_gradual.lock` using the gradual workflow:
  - `bundle exec rake rubocop_gradual:autocorrect` (preferred)
  - `bundle exec rake rubocop_gradual:force_update` (only when you cannot fix the violations immediately)

As a general rule, fix style issues rather than ignoring them. For example, our specs should follow RSpec conventions like using `described_class` for the class under test.

## Contributors

Your picture could be here!

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/galtzo-floss/gitmoji-regex/-/graphs/main][🚎contributors-gl]

## For Maintainers

### One-time, Per-maintainer, Setup

**IMPORTANT**: If you want to sign the build you create,
your public key for signing gems will need to be picked up by the line in the
`gemspec` defining the `spec.cert_chain` (check the relevant ENV variables there).
All releases to RubyGems.org will be signed.
See: [RubyGems Security Guide][🔒️rubygems-security-guide]

NOTE: To build without signing the gem you must set `SKIP_GEM_SIGNING` to some value in your environment.

### To release a new version:

1. Run `bin/setup && bin/rake` as a "test, coverage, & linting" sanity check
2. Update the version number in `version.rb`, and ensure `CHANGELOG.md` reflects changes
3. Run `bin/setup && bin/rake` again as a secondary check, and to update `Gemfile.lock`
4. Run `git commit -am "🔖 Prepare release v<VERSION>"` to commit the changes
5. Run `git push` to trigger the final CI pipeline before release, and merge PRs
    - NOTE: Remember to [check the build][🧪build].
6. Run `export GIT_TRUNK_BRANCH_NAME="$(git remote show origin | grep 'HEAD branch' | cut -d ' ' -f5)" && echo $GIT_TRUNK_BRANCH_NAME`
7. Run `git checkout $GIT_TRUNK_BRANCH_NAME`
8. Run `git pull origin $GIT_TRUNK_BRANCH_NAME` to ensure latest trunk code
9. Set `SOURCE_DATE_EPOCH` so `rake build` and `rake release` use same timestamp, and generate same checksums
    - Run `export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH`
    - If the echo above has no output, then it didn't work.
    - Note: `zsh/datetime` module is needed, if running `zsh`.
    - In older versions of `bash` you can use `date +%s` instead, i.e. `export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH`
10. Run `bundle exec rake build`
11. Run `bin/gem_checksums` (more context [1][🔒️rubygems-checksums-pr], [2][🔒️rubygems-guides-pr])
    to create SHA-256 and SHA-512 checksums. This functionality is provided by the `stone_checksums`
    [gem][💎stone_checksums].
    - The script automatically commits but does not push the checksums
12. Run `bundle exec rake release` which will create a git tag for the version,
    push git commits and tags, and push the `.gem` file to [rubygems.org][💎rubygems]

[🚎src-main]: https://gitlab.com/galtzo-floss/gitmoji-regex
[🧪build]: https://github.com/galtzo-floss/gitmoji-regex/actions
[🤝conduct]: https://gitlab.com/galtzo-floss/gitmoji-regex/-/blob/main/CODE_OF_CONDUCT.md
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/galtzo-floss/gitmoji-regex/graphs/contributors
[🚎contributors-gl]: https://gitlab.com/galtzo-floss/gitmoji-regex/-/graphs/main
[🖐contributors-img]: https://contrib.rocks/image?repo=galtzo-floss/gitmoji-regex
[💎rubygems]: https://rubygems.org
[🔒️rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
[🔒️rubygems-checksums-pr]: https://github.com/rubygems/rubygems/pull/6022
[🔒️rubygems-guides-pr]: https://github.com/rubygems/guides/pull/325
[💎stone_checksums]: https://github.com/galtzo-floss/stone_checksums
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[🏃‍♂️runner-tool-cache]: https://github.com/ruby/ruby-builder/releases/tag/toolcache
