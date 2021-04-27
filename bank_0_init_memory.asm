asect 0x00
	#0b00000000
      #^^^^^^^^
      #||||||||
      #|||||||> Error
      #||||||> W\R to\from field
      #|||||> Computing
      #||||> Waiting user action
      #|||> Game stopped
      #||> Initializing memory
      #|> Set button register to 0
      #> Ready
		addsp 0xF0
		ldi r0, 0x0f
		ldi r1, 0b00100000
		st r0, r1  
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
		
		ldi r0, 0x0f
		ldi r1, 0b00000000
		st r0, r1
		
		ldi r0, 0x1E
		ldi r1, 3
		st r0, r1
		
		ldi r0, 1
		br MEM_SWITCH
		asect 0xF7
		MEM_SWITCH:
	ldi r1, 0xff	
	st r1, r0
	br 0

end