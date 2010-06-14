module Restfulie
  module Server
    module ActionController #:nodoc:
      if defined?(::ActionController) || defined?(::ApplicationController)
        autoload :ParamsParser, 'restfulie/server/action_controller/params_parser'
        autoload :LastModifiedResponder, 'restfulie/server/action_controller/last_modified_responder'
        autoload :ExpiresResponder, 'restfulie/server/action_controller/expires_responder'
        autoload :CacheableResponder, 'restfulie/server/action_controller/cacheable_responder'
        autoload :CreatedResponder, 'restfulie/server/action_controller/created_responder'
        autoload :RestfulResponder, 'restfulie/server/action_controller/restful_responder'
        autoload :Base, 'restfulie/server/action_controller/base'
      end
    end
  end
end

require 'restfulie/server/action_controller/patch'
