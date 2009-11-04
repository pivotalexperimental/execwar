# Specify a dependency on rails. When the bundler downloads gems,
# it will download rails as well as all of rails' dependencies (such as
# activerecord, actionpack, etc...)
#
# At least one dependency must be specified
gem "rails", "2.3.4"

# Specify a dependency rspec, but only require that gem in the "testing"
# environment. :except is also a valid option to specify environment
# restrictions.
# gem "rspec", "1.2.9", :only => :testing

# Specify a dependency, but specify that it is already present and expanded
# at vendor/rspec. Bundler will treat rspec as though it was the rspec gem
# for the purpose of gem resolution: if another gem depends on a version
# of rspec satisfied by "1.1.6", it will be used.
#
# If a gemspec is found in the directory, it will be used to specify load
# paths and supply additional dependencies.
#
# Bundler will also recursively search for *.gemspec, and assume that
# gemspecs it finds represent gems that are rooted in the same directory
# the gemspec is found in.
# gem "rspec", "1.2.9", :vendored_at => "vendor/rspec"

# Works exactly like :vendored_at, but first downloads the repo from
# git and handles stashing the files for you. As with :vendored_at,
# Bundler will automatically use *.gemspec files in the root or anywhere
# in the repository.
# gem "rails", "3.0.pre", :git => "git://github.com/rails/rails.git"

# Add http://gems.github.com as a source that the bundler will use
# to find gems listed in the manifest. By default,
# http://gems.rubyforge.org is already added to the list.
#
# This is an optional setting.
# source "http://gems.github.com"

# Specify where the bundled gems should be stashed. This directory will
# be a gem repository where all gems are downloaded to and installed to.
#
# This is an optional setting.
# The default is: vendor/gems
bundle_path "vendor/bundled_gems"

# Specify where gem executables should be copied to.
#
# This is an optional setting.
# The default is: bin
# bin_path "bin"

# Specify that rubygems should be completely disabled. This means that it
# will be impossible to require it and that available gems will be
# limited exclusively to gems that have been bundled.
#
# The default is to automatically require rubygems. There is also a
# `disable_system_gems` option that will limit available rubygems to
# the ones that have been bundled.
disable_rubygems
disable_system_gems