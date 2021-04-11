asect	0x00
	# WRITE YOUR CODE HERE
	ldi r0, 0xFB
	ld r0, r1
	while 
	tst r1
	stays z
	ld r0, r1
	wend
	ldi r0, 0x1F
	st r0, r1
	ldi r0, 0b01000000
	ldi r1, 0xf0
	st r1, r0
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

	ldi r0, 0
	br 0xF7
	#перед попаданием в функцию в r0 должен быть адрес банки для перехода
	#switch to 2 bank
asect 0xF7
	ldi r1, 0xff	
	st r1, r0
	br 0
	
halt
end