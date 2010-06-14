module Restfulie
  module Server
    module ActionController
      module LastModifiedResponder  
        def to_format
          do_http_cache(self)
        end
        
        # default implementation that will check whether caching can be applied
        def do_http_cache?(responder)
          responder.resources.flatten.select do |resource|
            resource.respond_to?(:updated_at)
          end &&
            responder.controller.response.last_modified.nil? &&
            !new_record?(responder)
        end

        def do_http_cache(responder)
          return false unless do_http_cache?(responder)

          timestamp = responder.resources.flatten.select do |resource|
            resource.respond_to?(:updated_at)
          end.map do |resource|
            (resource.updated_at || Time.now).utc
          end.max

          responder.controller.response.last_modified = timestamp if timestamp
        end

        def new_record?(responder)
          responder.resource.respond_to?(:new_record?) && responder.resource.new_record?
        end
      end
    end
  end
end