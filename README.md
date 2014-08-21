### Simple Ruby HTTP Request Parser

Accepts an active socket object and returns a parsed request object as a hash.

```ruby
  require 'socket'
  require_relative './http_request'

  server = TCPServer.new 2000

  client = server.accept

  request = HTTPRequest.parse(client)

  # {
  #   :path => "/",
  #   :verb => "POST",
  #   :query_string => nil,
  #   :headers =>
  #   {
  #     "Host" => "localhost:2000",
  #     "Connection" => "keep-alive",
  #     "Content-Length" => "12",
  #     "Cache-Control" => "no-cache",
  #     "Origin" => "chrome-extension://fdmmgilgnpjigdojojpjoooidkmcomcm",
  #     "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36",
  #     "Content-Type" => "application/json, application/x-www-form-urlencoded",
  #     "Accept" => "*/*",
  #     "Accept-Encoding" => "gzip,deflate,sdch",
  #     "Accept-Language" => "en-US,en;q=0.8"
  #   }
  #   :body =>"shmee=orange"
  # }

  client.close
```