#require 'activesupport/dependencies'
ActiveSupport::Dependencies.module_eval do
  def search_for_file(path_suffix)
    path_suffix = path_suffix + '.rb' unless path_suffix.ends_with? '.rb'
    load_paths.each do |root|
      path = File.join(root, path_suffix)
      return path if File.file? path
      path = File.join(root, path_suffix.sub(/\.rb$/, '.class'))
      return path.sub(/\.class$/, '') if File.file? path
    end
    nil
  end
end

#require 'rails/initializer'
Rails::Initializer.module_eval do
  def load_application_classes
    if configuration.cache_classes
      configuration.eager_load_paths.each do |load_path|
        matcher = /\A#{Regexp.escape(load_path)}(.*)(?:\.rb|\.class)\Z/
        Dir.glob("#{load_path}/**/*").sort.each do |file|
          if matcher === file
            require_dependency $1
          end
        end
      end
    end
  end
end
