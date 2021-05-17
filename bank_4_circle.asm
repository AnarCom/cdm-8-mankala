asect 0x00
br MAIN
CHANGE_QUEUE_OF_PLAYER:
	ldi r0, 0xFB
	ldi r1, 1
	st r0, r1
	rts

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
		# тут ДоЛжНа быть обработка того, что мы переложили в 0 и в свою ячейку
		
		ldi r1, 0x1E
		ld r1, r1
		dec r1
		dec r1
		
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
		fi
		
		ldi r0, 0x1F
		ldi r1, 0
		st r0, r1
		ldi r0, 0x0F
		ldi r1, 0b00000000
		st r0, r1
rts



MAIN:
	jsr CIRCLE_NUMBERS

	ldi r0, 1
	br CHANGE
	#halt
asect 0xF7
	CHANGE:
	ldi r1, 0xff	
	st r1, r0
	br 0
end.