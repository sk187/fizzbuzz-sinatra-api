require 'sinatra'
require 'JSON'

get '/api' do
	word = params['word']
	max_value = params['max_value'].to_i
	
	def word_eval(word)
		if ['fizz','buzz','fizzbuzz'].include? word
			status 200
		else
			false
		end						
	end 
	
	def num_eval(max_value)
		num = max_value.to_i
		if num == 0
			false
		else
			status 200
		end
	end

	def num_array_builder(word, max)
		case word
			when 'fizz'
				calculate(3, max+2, max+1)
			when 'buzz'
				calculate(5, max+2, max+1)
			when 'fizzbuzz'
				calculate(3, 5, max+1)
		end
	end

	def calculate(divisor1, divisor2, max)
		start = 1
		num_array = []
		while start < max
			if start%divisor1 == 0
				num_array.push(start)
			end

			if start%divisor2 == 0 
				num_array.push(start)
			end
			start+=1
		end
		content_type :JSON
		{status: 'ok', numbers: num_array}.to_json
	end
	
	
	if word_eval(word) && num_eval(max_value)
		num_array_builder(word, max_value)
	else
		status 400
		content_type :JSON
		{status: 'error', numbers: []}.to_json
	end

end

