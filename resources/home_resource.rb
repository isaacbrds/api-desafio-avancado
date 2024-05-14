get '/' do
    content_type :json # Set response content type to JSON
    { message: 'Alô mundo!', endpoints: ["/clientes"] }.to_json
end