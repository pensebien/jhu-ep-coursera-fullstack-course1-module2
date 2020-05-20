some_var = "false"
another_var = "nil"

case some_var
when "pink elephant"
	puts("Dont think about the pink elephant!")
when false
	puts("Looks like this one should execute")
else
	case another_var
	
	when another_var.nil?
		puts("Question mark in the method name?")
	else
		puts("I guess nothing matched... But why?")
	end
	
end
