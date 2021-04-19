
asect	0x00
	# WRITE YOUR CODE HERE
	br MAIN
	
	INIT_MEMORY:
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
		ldi r0, 0x0E
		ldi r1, 1
		st r0, r1
		
		ldi r0, 0x0f
		ldi r1, 0b00000000
		st r0, r1
	rts
	# END INIT MEMORY
	#BEGIN OF DISPLAY DRAW
	WRITE_TO_FIELD:
	ldi r0, 0x0f
		ldi r1, 0b00000010
		st r0, r1  
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
	ldi r0, 0x0f
		ldi r1, 0b00000000
		st r0, r1
	rts
	
	
	CIRCLE_NUMBERS:
		ldi r0, 0x1F
		ld r0, r1
		#Ожидание числа на входе (по логике можно выпилить)
		while
		tst r1
		stays z
		ld r0, r1
		wend
		#Поиск id ячейки
		ldi r0, 0x11
		ld r0, r2
		while
		sub r1, r2
		stays nz 
		inc r0
		ld r0, r2
		wend
		# переход к адресу значения
		ldi r3, 0x10
		sub r0, r3
		move r3, r0
		ld r0, r1
		# зануление ячейки
		ldi r2, 0
		st r0, r2
		#обработка перекладывания
		while 
		tst r1
		stays nz
		inc r0
		ld r0, r2
		inc r2
		st r0, r2
		dec r1
		wend
		# тут ДоЛжНа быть обработка того, что мы переложили в 0 и в финальную ячейку
		ldi r0, 0x1F
		ldi r1, 0
		st r0, r1
	rts
	#BEGIN MAIN
	MAIN:
	#забиваем на адрес возврата, чтобы не нагадить в кучу
	pop r0
	#check that initializing is needed
	ldi r0, 0x0E
	ld r0, r0
	if
	tst r0
	is z
	addsp 0xF0
	jsr INIT_MEMORY
	else
	jsr CIRCLE_NUMBERS
	fi
	jsr WRITE_TO_FIELD  
	ldi r0, 0x1E
	ld r0, r1
	if
	tst r1
	is z
	ldi r1, 1
	else
	ldi r1, 0
	fi
	st r0, r1
	inc r1
	move r1, r0
	br 0xF6
	#перед попаданием в функцию в r0 должен быть адрес банки для перехода
	#switch to 2 bank
asect 0xF7
	ldi r1, 0xff	
	st r1, r0
	br 0
	
halt
end