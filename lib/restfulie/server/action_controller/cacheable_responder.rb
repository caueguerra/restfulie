class Expires
  def do_http_cache(responder)
    if responder.options[:expires_in]
      responder.controller.send :expires_in,responder.options[:expires_in]
      true
    else
      false
    end
  end
end

module Restfulie
  module Server
    module ActionController
      module CacheableResponder
        
        CACHES = [::Expires.new]
        
        def to_format
          cached = CACHES.inject(false) do |cached, cache|
            cached || cache.do_http_cache(self)
          end
          if ::ActionController::Base.perform_caching && !cached.nil?
            set_public_cache_control!
            head :not_modified if fresh = request.fresh?(controller.response)
            fresh
          else
            super
          end
        end
          
        def set_public_cache_control!
          cache_control = controller.response.headers["Cache-Control"].split(",").map {|k| k.strip }
          cache_control.delete("private")
          cache_control.delete("no-cache")
          cache_control << "public"
          controller.response.headers["Cache-Control"] = cache_control.join(', ')
        end

      end
    end
  end
end
