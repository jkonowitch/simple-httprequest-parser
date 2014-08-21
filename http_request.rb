module HTTPRequest
  def self.parse(connection)
    request = {}
    
    headers = self.read_headers(connection).split("\r\n")

    request[:path], request[:verb], request[:query_string] = parse_resource(headers.shift).values_at(:path, :verb, :query_string)

    request[:headers] = self.parse_headers(headers)

    request[:body] = self.read_body(request, connection)

    return request
  end

  private

  def self.parse_resource(resource)
    verb, full_path = resource.split(" ")
    path, query_string = full_path.split("?")

    return { path: path, verb: verb, query_string: query_string }
  end

  def self.read_headers(connection)
    headers = ""
    
    while (line = connection.gets) != "\r\n"
      headers << line
    end

    return headers
  end

  def self.parse_headers(headers)
    headers.reduce({}) do |parsed, line|
      k, v = line.split(": ")
      parsed[k] = v
      parsed
    end
  end

  def self.read_body(request, connection)
    body = ""

    if (body_length = request[:headers]["Content-Length"])
      body << connection.read(body_length.to_i)
    end

    return body
  end
end