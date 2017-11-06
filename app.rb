require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
require 'pry'

include SendGrid

get '/' do
  erb :index
end

post '/' do
from = Email.new(email: params['email'])
to = Email.new(email: 'patrickcolleton@gmail.com')
p params[:email]
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: params['body'])
mail = Mail.new(from, subject, to, content)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
erb :index
end
