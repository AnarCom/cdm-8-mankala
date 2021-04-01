	asect	0x00
	# WRITE YOUR CODE HERE
	ldi r0, 1
	ldi r1, 2
	add r0, r1	
	ldi r3, 255
	ldi r2, 1
	st r3, r2
	asect 0xaa
	ldi r1, 12
	br 0x00
	halt
inputs>
endinputs>
	end
