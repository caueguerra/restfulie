module Restfulie
  module Server
    module ActionController
      module ExpiresResponder  
        def to_format
          if options[:expires_in]
            controller.send :expires_in, options[:expires_in]
          else
            super
          end
        end
      end
    end
  end
end