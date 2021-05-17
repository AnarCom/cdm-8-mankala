asect 0x00
MAIN:
	jsr INIT_MEMORY
	ldi r0, 0x1f
	ldi r1, 0x01
	st r0, r1
	
	ldi r0, 0x1E
    ldi r1, 3
    st r0, r1

	ldi r0, 0x01
	ldi r1, 0x00
	st r0, r1
	
	ldi r0, 0x00
	ldi r1, 0x01
	st r0, r1

	jsr CIRCLE_NUMBERS
	halt
CHANGE_QUEUE_OF_PLAYER:
	rts
INIT_MEMORY: 
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
		#while
		#tst r1
		#stays z
		#ld r0, r1
		#wend
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
		# тут ДоЛжНа быть обработка того, что мы переложили в 0 и в свою ячейку
		
		ldi r1, 0x1E
		ld r1, r1
			dec r1
			dec r1
			push r1
		if
			tst r1
		is z
			ldi r2, 0x0D
		else
			ldi r2, 0x06
		fi
		
		if
			sub r0, r2
		is z
			jsr CHANGE_QUEUE_OF_PLAYER
			pop r3
		else
				pop r3
			ldi r1, 0x07
			sub r0, r1 #r1 - imp
			if
				tst r3
			is z
				if
					tst r1
				is pl
					ldi r2, 1
				else
					ldi r2, 0
				fi
			else
				if
					tst r1
				is mi
					ldi r2, 1
				else
					ldi r2, 0
				fi
			fi
			if
				tst r2
			is nz
				jsr CHANGE_QUEUE_OF_PLAYER
			fi
			
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
					halt 
				else
					ldi r2, 12
					move r0, r3
					while
						tst r3
					stays nz
						dec r2
						dec r2
						dec r3
					wend 
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
			fi
			
		fi
#		ldi r0, 0x1F
#		ldi r1, 0
#		st r0, r1
#		ldi r0, 0x0F
#		ldi r1, 0b00000000
#		st r0, r1
rts
end.
