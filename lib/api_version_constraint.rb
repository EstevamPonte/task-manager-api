class ApiVersionConstraint
    def initialize(options)
        @version = options[:version]
        @default = options[:default]
    end

    def matches?(req)
       @default || req.headers['Accept'].include?("application/vnd.taskmanager.v#{@version}")
    end
end

# metodos que terminam com '?' sao metodos que retorna true ou false 