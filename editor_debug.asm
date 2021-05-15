asect 0x00
br MAIN
CHANGE_QUEUE_OF_PLAYER:
	ldi r0, 0x1E
	ld r0, r0
	ldi r1, 2
	if
	sub r0, r1
	is z
		ldi r1, 3
	else
		ldi r1, 2
	fi
	ldi r0, 0x1e
	st r0, r1
	rts
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
	
		ldi r1, 0x0C
		ldi r0, 0
		st r1, r0
	rts
	# END INIT MEMORY
# loads hole to skip to r3
LOAD_SKIPPING_HOLE:
	# 2 - AI
	# 3 - People
	ldi r3, 0x1E
	ld r3, r3
	dec r3
	dec r3
	
	if
		tst r3
	is z
		ldi r3, 0x06
	else
		ldi r3, 0x0D
	fi
	rts
CIRCLE_NUMBERS:
		ldi r0, 0x0F
		ldi r1, 0b00000100
		st r0, r1
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
		 
		inc r0
		
		jsr LOAD_SKIPPING_HOLE
		
		if 
			sub r0, r3
		is z
			inc r0
		fi
		
		ldi r3, 0x0E
		if
			sub r0, r3
		is pl
		ldi r0, 0
		fi
		
		ld r0, r2
		inc r2
		st r0, r2
		dec r1
		wend
		# тут ДоЛжНа быть обработка того, что мы переложили в 0 и в финальную ячейку
		ldi r1, 0x1E
		ld r1, r1
		ldi r2, 2
		if
			sub r2, r1
		is z 
		ldi r1, 0x0D
		else
			ldi r1, 0x06
		fi
		if
			sub r0, r1
		is z
		jsr CHANGE_QUEUE_OF_PLAYER
		else
			move r0, r1
			ld r1, r1
			ldi r2, 1
			if
			sub r1, r2
			is z
				ldi r1, 0x1E
				ld r1, r1
				ldi r2, 2
				if
					sub r1, r2
				is z
					ldi r2, -8
				else
					ldi r2, 8
				fi
				
				move r0, r1
				add r2, r1
				ldi r3, 0
				st r0, r3
				ld r1, r2
				inc r2
				st r1, r3
				
				ldi r1, 0x1E
				ld r1, r1
				ldi r0, 2
				if
					sub r0, r1
				is z 
					ldi r1, 0x0D
				else
					ldi r1, 0x06
				fi
				# r2 - количество шариков, которые нужно переложить 
				ld r1, r0
				add r2, r0
				st r1, r0
			
			# если в лунке значение 1, то нужно что-то делать
			halt
			fi
		fi
		
		ldi r0, 0x1F
		ldi r1, 0
		st r0, r1
		ldi r0, 0x0F
		ldi r1, 0b00000000
		st r0, r1
	rts
	
	MAIN:
	jsr INIT_MEMORY
	ldi r0, 0x1f
	ldi r1, 0x0A
	st r0, r1
	ldi r0, 0x1E
        ldi r1, 2
        st r0, r1
	ldi r0, 0
	ldi r1, 0
	ldi r2, 0
	ldi r3, 0
	jsr CIRCLE_NUMBERS
	halt
end.
