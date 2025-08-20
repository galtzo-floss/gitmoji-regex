# frozen_string_literal: true

# Galtzo FLOSS Rakefile v1.0.11 - 2025-08-19
# Ruby 2.3 (Safe Navigation) or higher required
#
# CHANGELOG
# v1.0.0 - initial release w/ support for rspec, minitest, rubocop, reek, yard, and stone_checksums
# v1.0.1 - fix test / spec tasks running 2x
# v1.0.2 - fix duplicate task warning from RuboCop
# v1.0.3 - add bench tasks to run mini benchmarks (add scripts to /benchmarks)
# v1.0.4 - add support for floss_funding:install
# v1.0.5 - add support for halting in Rake tasks with binding.b (from debug gem)
# v1.0.6 - add RBS files and checksums to YARD-generated docs site
# v1.0.7 - works with vanilla ruby, non-gem, bundler-managed, projects
# v1.0.8 - improved Dir globs, add back and document rbconfig dependency
# v1.0.9 - add appraisal:update task to update Appraisal gemfiles and autocorrect with RuboCop Gradual
# v1.0.10 - add ci:act to run GHA workflows locally, and get status of remote workflows
# v1.0.11 - ci:act workflows are populated entirely dynamically, based on existing files
#
# MIT License (see License.txt)
#
# Copyright (c) 2025 Peter H. Boling (galtzo.com)
#
# Expected to work in any project that uses Bundler.
#
# Sets up tasks for appraisal, floss_funding, rspec, minitest, rubocop, reek, yard, and stone_checksums.
#
# rake appraisal:update                 # Update Appraisal gemfiles and run RuboCop Gradual autocorrect
# rake bench                            # Run all benchmarks (alias for bench:run)
# rake bench:list                       # List available benchmark scripts
# rake bench:run                        # Run all benchmark scripts (skips on CI)
# rake build                            # Build gitmoji-regex-1.0.2.gem into the pkg directory
# rake build:checksum                   # Generate SHA512 checksum of gitmoji-regex-1.0.2.gem into the checksums directory
# rake build:generate_checksums         # Generate both SHA256 & SHA512 checksums into the checksums directory, and git...
# rake bundle:audit:check               # Checks the Gemfile.lock for insecure dependencies
# rake bundle:audit:update              # Updates the bundler-audit vulnerability database
# rake ci:act[opt]                      # Run 'act' with a selected workflow
# rake clean                            # Remove any temporary products
# rake clobber                          # Remove any generated files
# rake coverage                         # Run specs w/ coverage and open results in browser
# rake floss_funding:install            # (stub) floss_funding is unavailable
# rake install                          # Build and install gitmoji-regex-1.0.2.gem into system gems
# rake install:local                    # Build and install gitmoji-regex-1.0.2.gem into system gems without network ac...
# rake reek                             # Check for code smells
# rake reek:update                      # Run reek and store the output into the REEK file
# rake release[remote]                  # Create tag v1.0.2 and build and push gitmoji-regex-1.0.2.gem to rubygems.org
# rake rubocop                          # alias rubocop task to rubocop_gradual
# rake rubocop_gradual                  # Run RuboCop Gradual
# rake rubocop_gradual:autocorrect      # Run RuboCop Gradual with autocorrect (only when it's safe)
# rake rubocop_gradual:autocorrect_all  # Run RuboCop Gradual with autocorrect (safe and unsafe)
# rake rubocop_gradual:check            # Run RuboCop Gradual to check the lock file
# rake rubocop_gradual:force_update     # Run RuboCop Gradual to force update the lock file
# rake spec                             # Run RSpec code examples
# rake test                             # Run tests
# rake yard                             # Generate YARD Documentation

DEBUGGING = ENV.fetch("DEBUG", "false").casecmp("true").zero?

# External gems
require "bundler/gem_tasks" if !Dir[File.join(__dir__, "*.gemspec")].empty?
require "rbconfig" if !Dir[File.join(__dir__, "benchmarks")].empty? # Used by `rake bench:run`
require "debug" if DEBUGGING

defaults = []

is_ci = ENV.fetch("CI", "false").casecmp("true") == 0

### DEVELOPMENT TASKS
# Setup Floss Funding
begin
  require "floss_funding"
  FlossFunding.install_tasks
rescue LoadError
  desc("(stub) floss_funding is unavailable")
  namespace(:floss_funding) do
    task("install") do # rubocop:disable Rake/Desc
      warn("NOTE: floss_funding isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
    end
  end
end

# Setup Kettle Soup Cover
begin
  require "kettle-soup-cover"

  Kettle::Soup::Cover.install_tasks
  # NOTE: Coverage on CI is configured independent of this task.
  #       This task is for local development, as it opens results in browser
  defaults << "coverage" unless Kettle::Soup::Cover::IS_CI
rescue LoadError
  desc("(stub) coverage is unavailable")
  task("coverage") do
    warn("NOTE: kettle-soup-cover isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup Bundle Audit
begin
  require "bundler/audit/task"

  Bundler::Audit::Task.new
  defaults.push("bundle:audit:update", "bundle:audit")
rescue LoadError
  desc("(stub) bundle:audit is unavailable")
  task("bundle:audit") do
    warn("NOTE: bundler-audit isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
  desc("(stub) bundle:audit:update is unavailable")
  task("bundle:audit:update") do
    warn("NOTE: bundler-audit isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup RSpec
begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)
  # This takes the place of `coverage` task when running as CI=true
  defaults << "spec" if !defined?(Kettle::Soup::Cover) || Kettle::Soup::Cover::IS_CI
rescue LoadError
  desc("spec task stub")
  task(:spec) do
    warn("NOTE: rspec isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup MiniTest
begin
  require "rake/testtask"

  Rake::TestTask.new(:test) do |t|
    t.test_files = FileList["tests/**/test_*.rb"]
  end
rescue LoadError
  desc("test task stub")
  task(:test) do
    warn("NOTE: minitest isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# rubocop:disable Rake/DuplicateTask
if Rake::Task.task_defined?("spec") && !Rake::Task.task_defined?("test")
  desc "run spec task with test task"
  task test: :spec
elsif !Rake::Task.task_defined?("spec") && Rake::Task.task_defined?("test")
  desc "run test task with spec task"
  task spec: :test
else
  # Add spec as pre-requisite to 'test'
  Rake::Task[:test].enhance(["spec"])
end
# rubocop:enable Rake/DuplicateTask

# Setup RuboCop-LTS
begin
  require "rubocop/lts"

  Rubocop::Lts.install_tasks
  # Make autocorrect the default rubocop task
  defaults << "rubocop_gradual:autocorrect"
rescue LoadError
  desc("(stub) rubocop_gradual is unavailable")
  task(:rubocop_gradual) do
    warn("NOTE: rubocop-lts isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup Reek
begin
  require "reek/rake/task"

  Reek::Rake::Task.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = "{lib,spec,tests}/**/*.rb"
  end

  # Store current Reek output into REEK file
  require "open3"
  desc("Run reek and store the output into the REEK file")
  task("reek:update") do
    # Run via Bundler if available to ensure the right gem version is used
    cmd = [Gem.bindir ? File.join(Gem.bindir, "bundle") : "bundle", "exec", "reek"]

    output, status = Open3.capture2e(*cmd)

    File.write("REEK", output)

    # Mirror the failure semantics of the standard reek task
    unless status.success?
      abort("reek:update failed (reek reported smells). Output written to REEK")
    end
  end
  defaults << "reek:update" unless is_ci
rescue LoadError
  desc("(stub) reek is unavailable")
  task(:reek) do
    warn("NOTE: reek isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Setup Yard
begin
  require "yard"

  YARD::Rake::YardocTask.new(:yard) do |t|
    t.files = [
      # Source Splats (alphabetical)
      "lib/**/*.rb",
      "-", # source and extra docs are separated by "-"
      # Extra Files (alphabetical)
      "*.cff",
      "*.md",
      "*.txt",
      "checksums/**/*.sha256",
      "checksums/**/*.sha512",
      "REEK",
      "sig/**/*.rbs",
    ]
  end
  defaults << "yard"
rescue LoadError
  desc("(stub) yard is unavailable")
  task(:yard) do
    warn("NOTE: yard isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# Appraisal tasks
begin
  require "bundler"
rescue LoadError
  # ok
end

desc "Update Appraisal gemfiles and run RuboCop Gradual autocorrect"
task "appraisal:update" do
  bundle = Gem.bindir ? File.join(Gem.bindir, "bundle") : "bundle"

  run_in_unbundled = proc do
    env = {"BUNDLE_GEMFILE" => "Appraisal.root.gemfile"}

    # 1) BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
    ok = system(env, bundle)
    abort("appraisal:update failed: bundler install under Appraisal.root.gemfile") unless ok

    # 2) BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update
    ok = system(env, bundle, "exec", "appraisal", "update")
    abort("appraisal:update failed: bundle exec appraisal update") unless ok

    # 3) bundle exec rake rubocop_gradual:autocorrect
    ok = system(bundle, "exec", "rake", "rubocop_gradual:autocorrect")
    abort("appraisal:update failed: rubocop_gradual:autocorrect") unless ok
  end

  if defined?(Bundler)
    Bundler.with_unbundled_env(&run_in_unbundled)
  else
    run_in_unbundled.call
  end
end

### RELEASE TASKS
# Setup stone_checksums
begin
  require "stone_checksums"

  GemChecksums.install_tasks
rescue LoadError
  desc("(stub) build:generate_checksums is unavailable")
  task("build:generate_checksums") do
    warn("NOTE: stone_checksums isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end

# --- Benchmarks (dev-only) ---
namespace :bench do
  desc "List available benchmark scripts"
  task :list do
    bench_files = Dir[File.join(__dir__, "benchmarks", "*.rb")].sort
    if bench_files.empty?
      puts "No benchmark scripts found under benchmarks/."
    else
      bench_files.each { |f| puts File.basename(f) }
    end
  end

  desc "Run all benchmark scripts (skips on CI)"
  task :run do
    if ENV.fetch("CI", "false").casecmp("true").zero?
      puts "Benchmarks are disabled on CI. Skipping."
      next
    end

    ruby = RbConfig.ruby
    bundle = Gem.bindir ? File.join(Gem.bindir, "bundle") : "bundle"
    bench_files = Dir[File.join(__dir__, "benchmarks", "*.rb")].sort
    if bench_files.empty?
      puts "No benchmark scripts found under benchmarks/."
      next
    end

    use_bundler = ENV.fetch("BENCH_BUNDLER", "0") == "1"

    bench_files.each do |script|
      puts "\n=== Running: #{File.basename(script)} ==="
      if use_bundler
        cmd = [bundle, "exec", ruby, "-Ilib", script]
        system(*cmd) || abort("Benchmark failed: #{script}")
      else
        # Run benchmarks without Bundler to reduce overhead and better reflect plain ruby -Ilib
        begin
          require "bundler"
          Bundler.with_unbundled_env do
            system(ruby, "-Ilib", script) || abort("Benchmark failed: #{script}")
          end
        rescue LoadError
          # If Bundler isn't available, just run directly
          system(ruby, "-Ilib", script) || abort("Benchmark failed: #{script}")
        end
      end
    end
  end
end

desc "Run all benchmarks (alias for bench:run)"
task bench: "bench:run"

# --- CI helpers ---
namespace :ci do
  # rubocop:disable ThreadSafety/NewThread
  desc "Run 'act' with a selected workflow. Usage: rake ci:act[loc] (short code = first 3 letters of filename, e.g., 'loc' => locked_deps.yml), rake ci:act[locked_deps], rake ci:act[locked_deps.yml], or rake ci:act (then choose)"
  task :act, [:opt] do |_t, args|
    require "io/console"
    require "open3"
    require "net/http"
    require "json"
    require "uri"

    # Build mapping dynamically from workflow files; short code = first three letters of filename.
    # Collisions are resolved by first-come wins via ||= as requested.
    mapping = {}

    # Normalize provided option. Accept either short code or the exact yml/yaml filename
    choice = args[:opt]&.strip
    workflows_dir = File.join(__dir__, ".github", "workflows")

    # Determine actual workflow files present, and prepare dynamic additions excluding specified files.
    existing_files = if Dir.exist?(workflows_dir)
      Dir[File.join(workflows_dir, "*.yml")] + Dir[File.join(workflows_dir, "*.yaml")]
    else
      []
    end
    existing_basenames = existing_files.map { |p| File.basename(p) }

    # Reduce mapping choices to only those with a corresponding workflow file
    mapping.select! { |_k, v| existing_basenames.include?(v) }

    # Dynamic additions: any workflow in the directory not already in mapping, excluding these:
    exclusions = %w[
      auto-assign.yml
      codeql-analysis.yml
      danger.yml
      dependency-review.yml
      discord-notifier.yml
    ]
    dynamic_files = existing_basenames.uniq - mapping.values - exclusions

    # For internal status tracking and rendering, we use a display_code_for hash.
    # For mapped (short-code) entries, display_code is the short code.
    # For dynamic entries, display_code is empty string, but we key statuses by a unique code = the filename.
    display_code_for = {}
    mapping.keys.each { |k| display_code_for[k] = k }
    dynamic_files.each { |f| display_code_for[f] = "" }

    # Helpers
    get_branch = proc do
      out, status = Open3.capture2("git", "rev-parse", "--abbrev-ref", "HEAD")
      status.success? ? out.strip : nil
    end

    get_origin = proc do
      out, status = Open3.capture2("git", "config", "--get", "remote.origin.url")
      next nil unless status.success?
      url = out.strip
      # Support ssh and https URLs
      if url =~ %r{git@github.com:(.+?)/(.+?)(\.git)?$}
        [$1, $2.sub(/\.git\z/, "")]
      elsif url =~ %r{https://github.com/(.+?)/(.+?)(\.git)?$}
        [$1, $2.sub(/\.git\z/, "")]
      end
    end

    status_emoji = proc do |status, conclusion|
      case status
      when "queued"
        "⏳️"
      when "in_progress"
        "👟"
      when "completed"
        (conclusion == "success") ? "✅" : "🍅"
      else
        "⏳️"
      end
    end

    fetch_and_print_status = proc do |workflow_file|
      branch = get_branch.call
      org_repo = get_origin.call
      unless branch && org_repo
        puts "GHA status: (skipped; missing git branch or remote)"
        next
      end
      owner, repo = org_repo
      uri = URI("https://api.github.com/repos/#{owner}/#{repo}/actions/workflows/#{workflow_file}/runs?branch=#{URI.encode_www_form_component(branch)}&per_page=1")
      req = Net::HTTP::Get.new(uri)
      req["User-Agent"] = "ci:act rake task"
      token = ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"]
      req["Authorization"] = "token #{token}" if token && !token.empty?

      begin
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        if res.is_a?(Net::HTTPSuccess)
          data = JSON.parse(res.body)
          run = data["workflow_runs"]&.first
          if run
            status = run["status"]
            conclusion = run["conclusion"]
            emoji = status_emoji.call(status, conclusion)
            details = [status, conclusion].compact.join("/")
            puts "Latest GHA (#{branch}) for #{workflow_file}: #{emoji} (#{details})"
          else
            puts "Latest GHA (#{branch}) for #{workflow_file}: none"
          end
        else
          puts "GHA status: request failed (#{res.code})"
        end
      rescue StandardError => e
        puts "GHA status: error #{e.class}: #{e.message}"
      end
    end

    def run_act_for(file_path)
      # Prefer array form to avoid shell escaping issues
      ok = system("act", "-W", file_path)
      abort("ci:act failed: 'act' command not found or exited with failure") unless ok
    end

    def process_success_response(res, c, f, old = nil, current = nil)
      data = JSON.parse(res.body)
      run = data["workflow_runs"]&.first
      append = (old && current) ? " (update git remote: #{old} → #{current})" : ""
      if run
        st = run["status"]
        con = run["conclusion"]
        emoji = case st
        when "queued" then "⏳️"
        when "in_progress" then "👟"
        when "completed" then ((con == "success") ? "✅" : "🍅")
        else "⏳️"
        end
        details = [st, con].compact.join("/")
        [c, f, "#{emoji} (#{details})#{append}"]
      else
        [c, f, "none#{append}"]
      end
    end

    if choice && !choice.empty?
      # If user passed a filename directly (with or without extension), resolve it
      file = if mapping.key?(choice)
        mapping.fetch(choice)
      elsif /\.(yml|yaml)\z/.match?(choice)
        # Accept either full basename (without ext) or basename with .yml/.yaml
        choice
      else
        cand_yml = File.join(workflows_dir, "#{choice}.yml")
        cand_yaml = File.join(workflows_dir, "#{choice}.yaml")
        if File.file?(cand_yml)
          "#{choice}.yml"
        elsif File.file?(cand_yaml)
          "#{choice}.yaml"
        else
          # Fall back to .yml for error messaging; will fail below
          "#{choice}.yml"
        end
      end
      file_path = File.join(workflows_dir, file)
      unless File.file?(file_path)
        puts "Unknown option or missing workflow file: #{choice} -> #{file}"
        puts "Available options:"
        mapping.each { |k, v| puts "  #{k.ljust(3)} => #{v}" }
        # Also display dynamically discovered files
        unless dynamic_files.empty?
          puts "  (others) =>"
          dynamic_files.each { |v| puts "        #{v}" }
        end
        abort("ci:act aborted")
      end
      fetch_and_print_status.call(file)
      run_act_for(file_path)
      next
    end

    # No option provided: interactive menu with live GHA statuses via Threads (no Ractors)
    require "thread"

    tty = $stdout.tty?
    # Build options: first the filtered short-code mapping, then dynamic files (no short codes)
    options = mapping.to_a + dynamic_files.map { |f| [f, f] }

    # Add a Quit choice
    quit_code = "q"
    options_with_quit = options + [[quit_code, "(quit)"]]

    idx_by_code = {}
    options_with_quit.each_with_index { |(k, _v), i| idx_by_code[k] = i }

    # Determine repo context once
    branch = get_branch.call
    org = get_origin.call
    owner, repo = org if org
    token = ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"]

    puts "Select a workflow to run with 'act':"

    # Render initial menu with placeholder statuses
    placeholder = "[…]"
    options_with_quit.each_with_index do |(k, v), idx|
      status_col = (k == quit_code) ? "" : placeholder
      disp = (k == quit_code) ? k : display_code_for[k]
      line = format("%2d) %-3s => %-20s %s", idx + 1, disp, v, status_col)
      puts line
    end

    puts "(Fetching latest GHA status for branch #{branch || "n/a"} — you can type your choice and press Enter)"
    prompt = "Enter number or code (or 'q' to quit): "
    print prompt
    $stdout.flush

    # Thread + Queue to read user input
    input_q = Queue.new
    input_thread = Thread.new do
      line = $stdin.gets&.strip
      input_q << line
    end

    # Worker threads to fetch statuses and stream updates as they complete
    status_q = Queue.new
    workers = []

    # Capture a monotonic start time to guard against early race with terminal rendering
    start_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    options.each do |code, file|
      workers << Thread.new(code, file, owner, repo, branch, token, start_at) do |c, f, ow, rp, br, tk, st_at|
        begin
          # small initial delay if threads finish too quickly, to let the menu/prompt finish rendering
          now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
          delay = 0.12 - (now - st_at)
          sleep(delay) if delay && delay > 0

          if ow.nil? || rp.nil? || br.nil?
            status_q << [c, f, "n/a"]
            Thread.exit
          end
          uri = URI("https://api.github.com/repos/#{ow}/#{rp}/actions/workflows/#{f}/runs?branch=#{URI.encode_www_form_component(br)}&per_page=1")
          req = Net::HTTP::Get.new(uri)
          req["User-Agent"] = "ci:act rake task"
          req["Authorization"] = "token #{tk}" if tk && !tk.empty?
          res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
          status_q <<
            if res.is_a?(Net::HTTPSuccess)
              process_success_response(res, c, f)
            else
              [c, f, "fail #{res.code}"]
            end
        rescue StandardError
          status_q << [c, f, "err"]
        end
      end
    end

    # Live update loop: either statuses arrive or the user submits input
    statuses = Hash.new(placeholder)
    selected = nil

    loop do
      # Check for user input first (non-blocking)
      unless input_q.empty?
        selected = begin
          input_q.pop(true)
        rescue
          nil
        end
        break if selected
      end

      # Drain any available status updates without blocking
      begin
        code, file_name, display = status_q.pop(true)
        statuses[code] = display

        if tty
          idx = idx_by_code[code]
          if idx.nil?
            puts "status #{code}: #{display}"
            print(prompt)
          else
            move_up = options_with_quit.size - idx + 1 # 1 for instruction line + remaining options above last
            $stdout.print("\e[#{move_up}A\r\e[2K")
            disp = (code == quit_code) ? code : display_code_for[code]
            $stdout.print(format("%2d) %-3s => %-20s %s\n", idx + 1, disp, file_name, display))
            $stdout.print("\e[#{move_up - 1}B\r")
            $stdout.print(prompt)
          end
          $stdout.flush
        else
          puts "status #{code}: #{display}"
        end
      rescue ThreadError
        # Queue empty: brief sleep to avoid busy wait
        sleep(0.05)
      end
    end

    # Cleanup: kill any still-running threads
    begin
      workers.each { |t| t.kill if t&.alive? }
    rescue StandardError
      # ignore
    end
    begin
      input_thread.kill if input_thread&.alive?
    rescue StandardError
      # ignore
    end

    input = selected
    abort("ci:act aborted: no selection") if input.nil? || input.empty?

    # Normalize selection
    chosen_file = nil
    if input.match?(/^\d+$/)
      idx = input.to_i - 1
      if idx < 0 || idx >= options_with_quit.length
        abort("ci:act aborted: invalid selection #{input}")
      end
      code, val = options_with_quit[idx]
      if code == quit_code
        puts "ci:act: quit"
        next
      else
        chosen_file = val
      end
    else
      code = input
      if ["q", "quit", "exit"].include?(code.downcase)
        puts "ci:act: quit"
        next
      end
      chosen_file = mapping[code]
      abort("ci:act aborted: unknown code '#{code}'") unless chosen_file
    end

    file_path = File.join(workflows_dir, chosen_file)
    abort("ci:act aborted: workflow not found: #{file_path}") unless File.file?(file_path)

    # Print status for the chosen workflow (for consistency)
    fetch_and_print_status.call(chosen_file)
    run_act_for(file_path)
  end
  # rubocop:enable ThreadSafety/NewThread
end

task default: defaults
