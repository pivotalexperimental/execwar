
require 'action_controller'
ActionController::Helpers::ClassMethods.module_eval do
  def all_application_helpers
    extract = /^#{Regexp.quote(ActionController::Base.helpers_dir)}\/?(.*)_helper.(?:rb|class)$/
    Dir["#{ActionController::Base.helpers_dir}/**/*_helper.*"].map { |file|
      file.sub extract, '\1' if extract === file
    }.compact
  end
end



