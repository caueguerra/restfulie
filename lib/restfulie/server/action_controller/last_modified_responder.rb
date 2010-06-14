module Restfulie
  module Server
    module ActionController
      module LastModifiedResponder  
        def to_format
          do_http_cache
        end
        
        # default implementation that will check whether caching can be applied
        def do_http_cache?
          resources.flatten.select do |resource|
            resource.respond_to?(:updated_at)
          end &&
            controller.response.last_modified.nil? && !new_record?
        end

        def do_http_cache
          return false unless do_http_cache?

          timestamp = resources.flatten.select do |resource|
            resource.respond_to?(:updated_at)
          end.map do |resource|
            (resource.updated_at || Time.now).utc
          end.max

          controller.response.last_modified = timestamp if timestamp
        end

        def new_record?
          resource.respond_to?(:new_record?) && resource.new_record?
        end
      end
    end
  end
end