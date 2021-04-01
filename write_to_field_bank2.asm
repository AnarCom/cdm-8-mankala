asect	0x00
	# WRITE YOUR CODE HERE
#	addsp 0xF0
#	ldi r1, 13
#	ldi r2, 0
#	ldi r3, 4
#	while
#	tst r1
#	stays pl
#		st r2, r3
#		inc r2
#		dec r1
#	wend
	
#	ldi r0, 0
#	ldi r1, 6
#	st r1, r0
	
#	ldi r1, 13
#	st r1, r0
	
#	ldi r0, 1
#	ldi r1, 0x10
#	ldi r2, 6
	
#	while 
#	tst r2
#	stays pl
#	st r1, r0
#	dec r2
#	inc r0
#	inc r1
	
#	wend 
#	inc r0
#	ldi r2, 6
#	while 
#	tst r2
#	stays pl
#	st r1, r0
#	dec r2
#	inc r0
#	inc r1
	
#	wend
	
	
	
	
	
	# r1 - number 
	ldi r1, 0x0D
	#r2 - addres
	ldi r2, 0x1D
	
	while 
	tst r1
	stays pl
		ldi r0, 0b00010000
		#FC - addr + flag
		push r1
		push r2
		
		ld r1, r1
		ld r2, r2
		
		ldi r3, 0xFE
		st r3, r1
		#r2 - adress + flug
		or r0, r2
		ldi r3, 0xFC
		st r3, r2
		ldi r2, 0
		st r3, r2
		#FE - data to write
		
		pop r2
		pop r1 
		dec r1
		dec r2
	wend 
	halt
	#writing to memory cells values
	#changing value for SP
	
	#ldi r1, 0b00010001
	#ldi r0, 0xfc
	#ldi r2, 0xfe
	#st r2, r1
	#st r0, r1
	#halt
	#switch to 2 bank
asect 0xF7
	ldi r1, 0xff
	ldi r0, 2	
	st r1, r0
	br 0
halt
end
