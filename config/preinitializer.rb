if defined?(::JRUBY_COMPILED_WAR)
  # Set the gem home to the gem path when running as a war, to ensure we don't pick up any system gems, only gems bundled in the war
  ENV['GEM_HOME'] = Gem.path.first
end

require "rubygems"
require "geminstaller"
args = "--config #{File.expand_path(RAILS_ROOT)}/config/geminstaller.yml --exceptions"
GemInstaller.autogem(args)
