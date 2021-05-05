asect 0x00
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
		ldi r0, 0x10
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
		ldi r3, 0x0E 
		inc r0
		
		if
			sub r0, r3
		is z
		ldi r0, 0
		fi
		
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
	
	MAIN:
	jsr INIT_MEMORY
	ldi r0, 0x1f
	ldi r1, 0x0E
	st r0, r1
	ldi r0, 0
	ldi r1, 0
	ldi r2, 0
	ldi r3, 0
	jsr CIRCLE_NUMBERS
	halt
end.