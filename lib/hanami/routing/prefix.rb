# frozen_string_literal: true

require "delegate"
require "hanami/utils/path_prefix"

module Hanami
  module Routing
    # Prefix for routes.
    # Implementation of Hanami::Router#prefix
    #
    # @since 2.0.0
    # @api private
    #
    # @see Hanami::Router#prefix
    class Prefix < SimpleDelegator
      # @api private
      # @since 2.0.0
      def initialize(router, path, namespace, configuration, &blk)
        @router        = router
        @namespace     = namespace
        @configuration = configuration
        @path          = Utils::PathPrefix.new(path)
        __setobj__(@router)
        instance_eval(&blk)
      end

      # @api private
      # @since 2.0.0
      def get(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def post(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def put(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def patch(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def delete(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def trace(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def options(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(namespace: @namespace, configuration: @configuration), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def resource(name, options = {})
        super(name, options.merge(prefix: @path.relative_join(options[:prefix]), namespace: @namespace, configuration: @configuration))
      end

      # @api private
      # @since 2.0.0
      def resources(name, options = {})
        super(name, options.merge(prefix: @path.relative_join(options[:prefix]), namespace: @namespace, configuration: @configuration))
      end

      # @api private
      # @since 2.0.0
      def redirect(path, options = {}, &endpoint)
        super(@path.join(path), options.merge(to: @path.join(options[:to])), &endpoint)
      end

      # @api private
      # @since 2.0.0
      def mount(app, options)
        super(app, options.merge(at: @path.join(options[:at])))
      end

      # Supports nested prefix
      #
      # @api private
      # @since 2.0.0
      def prefix(path, &blk)
        self.class.new(self, path, @namespace, @configuration, &blk)
      end
    end
  end
end
