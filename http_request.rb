class HTTPRequest
  attr_reader :connection, :request

  def initialize(connection)
    @connection = connection
    @request = { path: "", verb: "", headers: {}, body: ""}
    
    parse_headers(read_headers)
    read_body
  end

  def [](key)
    return request[key]
  end

  private

  def read_headers
    headers = ""
    
    while (line = connection.gets) != "\r\n"
      headers << line
    end

    return headers
  end

  def parse_headers(headers)
    headers = headers.split("\r\n")

    self.request[:headers][:resource] = headers.shift

    headers.each do |line|
      k, v = line.split(": ")
      self.request[:headers][k] = v
    end
  end

  def read_body
    if request[:headers]["Content-Length"]
      body = connection.read(request[:headers]["Content-Length"].to_i)
      self.request[:body] = body
    end
  end
end