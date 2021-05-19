asect	0x00
	# WRITE YOUR CODE HERE
	START:
	ldi r0, 0x0f
	ldi r1, 0b00001000
	st r0, r1
	
	
	
	ldi r0, 0xF9
	ld r0, r1
	while 
	tst r1
	stays z
	ld r0, r1
	wend
	
	
	move r1, r2
	dec r2
	ld r2, r2
	if 
		tst r2
	is z
		ldi r0, 0x0f
		ldi r1, 0b01000001
		st r0, r1 
		
		ldi r0, 0x0f
		ldi r1, 0b00000000
		st r0, r1
		br START
	fi
	
	ldi r0, 0x1F
	st r0, r1
	
	ldi r0, 0x0f
	ldi r1, 0b01000000
	st r0, r1 
#	0b00000000
   #  ^^^^^^^^
   #  ||||||||
   #  |||||||> Error
   #  ||||||> W\R to\from field
   #  |||||> Computing
   #  ||||> Waiting user action
   #  |||> Game stopped
   #  ||> Initializing memory
   # |> Set button register to 0
  #  > Ready
	ldi r0, 0x0f
	ldi r1, 0b00000000
	ldi r0, 4
	
	br SWITCH_BANK
	#перед попаданием в функцию в r0 должен быть адрес банки для перехода
	#switch to 2 bank
	asect 0xF7
	SWITCH_BANK:
	ldi r1, 0xff	
	st r1, r0
	br 0
	
halt
end
