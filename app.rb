#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do 
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@date = params[:date]
	@time = params[:time]
	@fcker = params[:fcker]
	@color = params[:color]

	@title = 'Good!'
	@message = "#{@username} (#{@phone}) you have just booked #{@date} at #{@time}. Our #{@fcker} will fck your ass with #{@color} color of nation!"
	
	guestlist = File.open './public/guestlist.txt', 'a'
	guestlist.write "Guest #{@username} (phone: #{@phone}) has made appointment on #{@date} at #{@time} with Mr. #{@fcker} and #{@color} color \n"
	guestlist.close

	erb :contacts
end

get '/admin' do
	erb :admin
end 

post '/admin' do 
	@login = params[:login]
	@pas = params[:password]

	if @login == 'admin' && @pas == 'obana'
        @openlist = File.open './public/guestlist.txt', 'r'
		@zaebisto = '<p>You are axyeNNy chuvak!</p>'
		erb :admin
    else
        @warning = '<p>Wrong login or password!</p>'
        erb :admin
    end
end