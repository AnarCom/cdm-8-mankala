#address of data and adress of id
macro write_to_field /2
	push r0
	push r1
	push r2
	push r3
	#r0 - mask
	ldi r0, 0b00010000
	#r1 - adress of data to write
	#ldi r1, $1
	move $0, r1
	ld r1, r1
	#r2 - adress of id 
	#ldi r2, $2
	move $1, r1
	ld r2, r2
	or r0, r2
	
	ldi r3, 0xfe
	st r3, r1
	ldi r3, 0xfc
	st r3, r2
	ldi r2, 0
	st r3, r2
	pop r3
	pop r2
	pop r1
	pop r0
mend

asect	0x00
	# WRITE YOUR CODE HERE
	
	
	ldi r0, 0x0E
	ld r0, r0
	if
	tst r0
	is z
		addsp 0xF0
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
		ldi r0, 0x0E
		ldi r1, 1
		st r0, r1
	fi
	#write_to_field 0x00, 0x00
	ldi r0, 0x0D
	while 
	tst r0 
	stays pl
	ldi r1, 0x10
	add r0, r1
	ld r1, r1
	ldi r2, 0x10
	or r2, r1
	push r0
	
	ld r0, r0
	ldi r2, 0xfe
	st r2, r0
	ldi r2, 0xfc
	st r2, r1
	ldi r1, 0
	st r2, r1
	pop r0
	dec r0
	wend
	halt
	#switch to 2 bank
asect 0xF7
	ldi r1, 0xff
	ldi r0, 2	
	st r1, r0
	br 0
	
halt
end