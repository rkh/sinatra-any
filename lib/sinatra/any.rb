require 'sinatra/base'

module Sinatra

  module Any

    def any(path, *args, &blk)
      define_method("ANY #{path}", &blk)
      unbound_method = instance_method "ANY #{path}"
      passing = proc { unbound_method.bind(self).call; pass }
      %w(get post put delete head).each do |meth|
        send meth, path, *args, &passing
      end
    end

  end

  register Any
end
