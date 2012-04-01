module Exceptions
  class AuthenticationError < StandardError; end
  class ValidationError < AuthenticationError; end
end