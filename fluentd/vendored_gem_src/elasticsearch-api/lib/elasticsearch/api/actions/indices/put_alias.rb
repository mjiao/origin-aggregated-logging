# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Indices
      module Actions
        # Creates or updates an alias.
        #
        # @option arguments [List] :index A comma-separated list of index names the alias should point to (supports wildcards); use `_all` to perform the operation on all indices.
        # @option arguments [String] :name The name of the alias to be created or updated
        # @option arguments [Time] :timeout Explicit timestamp for the document
        # @option arguments [Time] :master_timeout Specify timeout for connection to master

        # @option arguments [Hash] :body The settings for the alias, such as `routing` or `filter`
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.5/indices-aliases.html
        #
        def put_alias(arguments = {})
          raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]
          raise ArgumentError, "Required argument 'name' missing" unless arguments[:name]

          arguments = arguments.clone

          _index = arguments.delete(:index)

          _name = arguments.delete(:name)

          method = Elasticsearch::API::HTTP_PUT
          path   = if _index && _name
                     "#{Utils.__listify(_index)}/_aliases/#{Utils.__listify(_name)}"
  end
          params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

          body = arguments[:body]
          perform_request(method, path, params, body).body
        end

        # Register this action with its valid params when the module is loaded.
        #
        # @since 6.2.0
        ParamsRegistry.register(:put_alias, [
          :timeout,
          :master_timeout
        ].freeze)
end
      end
  end
end
