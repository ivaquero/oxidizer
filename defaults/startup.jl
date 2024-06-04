atreplinit() do repl
	try
		@eval using OhMyREPL
	catch e
		@warn "error while importing OhMyREPL" e
	end
end

ENV["JULIA_NUM_THREADS"] = 8
