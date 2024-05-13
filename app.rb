require 'sinatra'

# Define a route for a sample API endpoint
get '/api/v1/alo/' do
    content_type :json # Set response content type to JSON
    { message: 'Este é um endpoint da sua aplicação!' }.to_json
end