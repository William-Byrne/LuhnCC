#An Application of the Luhn Algorithm for credit card validation (written in Ruby)
def validate(n)
  #Create a digit array
  arr = Math.log10(n).floor.downto(0).map {|x| (n / 10**x) % 10}

  #Lambdas describing conditional behavior depending on divisibility by 2
  evens = ->(i) {if i.even? then arr[i] *= 2 end}
  odds = ->(i) {if i.odd? then arr[i] *= 2 end}

  arr.each_index do |i| 
    arr.length.even? ? evens.call(i) : odds.call(i) #Double every other digit
    #If the value at an index is greater than 9, 
    #sum its digits (subtracting 9 is equivalent).
    if arr[i] > 9 then arr[i] -= 9 end 
  end

  #Take the sum over all elements in the Array
  arr.each_index {|i| if i != 0 then arr[0] += arr[i] end}

  #Find the congruence class of the sum mod 10. 
  #If it is the zero class, return true. Otherwise, return false.
  return arr[0] % 10 == 0
end

while true
	puts "Please enter a credit card # for validation or q to quit:"
	input = gets.chomp

	unless input.eql? "q"
		unless input.to_i < 1 
			if validate(input.to_i) 
				puts "Valid!"
			else
				puts "Invalid!"
			end
		else
			puts "#{input} is not a positive integer!"
		end
	else
		break
	end
end
