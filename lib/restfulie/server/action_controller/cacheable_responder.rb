module Restfulie
  module Server
    module ActionController
      module CacheableResponder        
        def to_format
          super
          if ::ActionController::Base.perform_caching
            set_public_cache_control!
            head :not_modified if fresh = request.fresh?(controller.response)
            fresh
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
