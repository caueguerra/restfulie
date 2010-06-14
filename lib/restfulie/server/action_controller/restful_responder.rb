module Restfulie
  module Server
    module ActionController
      class RestfulResponder < ::ActionController::Responder
        include LastModifiedResponder
        include ExpiresResponder
        include CacheableResponder
        include CreatedResponder
      end
    end
  end
end
