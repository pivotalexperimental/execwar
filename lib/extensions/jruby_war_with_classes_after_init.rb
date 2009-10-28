
require 'action_controller'
ActionController::Helpers::ClassMethods.module_eval do
  def all_application_helpers
    extract = /^#{Regexp.quote(ActionController::Helpers::HELPERS_DIR)}\/?(.*)_helper.(?:rb|class)$/
    Dir["#{ActionController::Helpers::HELPERS_DIR}/**/*_helper.*"].map { |file|
      file.sub extract, '\1' if extract === file
    }.compact
  end
end



