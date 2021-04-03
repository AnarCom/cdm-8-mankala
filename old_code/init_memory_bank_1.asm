asect	0x00
	# WRITE YOUR CODE HERE
	#writing to memory cells values
	#changing value for SP
	ldi r1, 0xF0
	addsp 0xF0
	#now stack starts with 0xF0
	
	#init of cels values
	ldi r1, 13
	ldi r2, 0
	ldi r3, 4
	while
	tst r1
	stays pl
		st r2, r3
		inc r2
		dec r1
	wend
	
	ldi r0, 0
	ldi r1, 6
	st r1, r0
	
	ldi r1, 13
	st r1, r0
	
	ldi r0, 1
	ldi r1, 0x10
	ldi r2, 6
	
	while 
	tst r2
	stays pl
	st r1, r0
	dec r2
	inc r0
	inc r1
	
	wend 
	inc r0
	ldi r2, 6
	while 
	tst r2
	stays pl
	st r1, r0
	dec r2
	inc r0
	inc r1
	
	wend
	
	br 0xF7
	#switch to 1 bank
asect 0xF7
	ldi r1, 0xff
	ldi r0, 1
	st r1, r0
	#	halt
	br 0
halt
end
