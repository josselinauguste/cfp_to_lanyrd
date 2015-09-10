module CFP
  class SnakeMiddleware < Faraday::Response::Middleware
    def call(env)
      response = @app.call(env)
      response.env[:body] = underscore_hash_keys(response.env[:body])
      response
    end

    private

    def underscore_hash_keys(hash)
      if hash.is_a? Hash
        Hash[hash.map { |k, v| [underscore(k), underscore_hash_keys(v)] }]
      elsif hash.is_a? Array
        hash.map { |a| underscore_hash_keys(a) }
      else
        hash
      end
    end

    def underscore(s)
      s.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
    end
  end
end
