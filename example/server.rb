require 'socket'
require 'pry'
require_relative '../http_request'

server = TCPServer.new 2000

client = server.accept

request = HTTPRequest.parse(client)

binding.pry

client.close