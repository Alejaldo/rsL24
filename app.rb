#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do 
	@error = 'something wrong epta'
	erb :about
end

get '/visit' do
	erb :visit
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

	hh = {
		:username => 'Enter correct name',
		:phone => 'Enter correct phone',
		:date => 'Enter correct date',
		:time => 'Enter correct time'
	}

	#hh.each do |k, v|
	#	if params[k] == ''
	#		@error = hh[k]
	#		return erb :visit
	#	end
	#end
	
	@error = hh.select { |k,_| params[k] == '' }.values.join(", ")
	if @error != ''
		return erb :visit
	end

	erb :message
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

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@name = params[:name]
	@mail = params[:mail]
	@body = params[:body]

	Pony.options = {
		:subject => "Message from #{@name}",
		:body => "#{@body}",
		:via => :smtp,
		:via_options => { 
			:address              => 'smtp.gmail.com', 
			:port                 => '587', 
			:enable_starttls_auto => true, 
			:user_name            => '__@gmail.com',
    		:password             => '__',
			:authentication       => :plain,
		}
	}
	
	Pony.mail(:to => '__@__')

	@obana = "Hey #{@name} your message has succesfully been sent to us!"

	erb :ura
end