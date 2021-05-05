asect 0x00
br MAIN
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
		#пропуск лунки противника
		if 
			sub r0, r3
		is z
			inc r0
		fi
		
		#циклическое замыкание лунок (если add лунки > max -> = min)
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
		ldi r0, 0x1F
		ldi r1, 0
		st r0, r1
	rts
	
	
MAIN: 
	pop r0
	ldi r0, 0x0E
	ld r0, r0
	#Память только была инициализирвоана?
	if
	tst r0
	is nz
	#Нет - обрабатываем перекладку шариков
	jsr CIRCLE_NUMBERS
	else
	#Да - ставим флаг, что были и просто инициалищируем поле
	ldi r0, 0x0E
	ldi r1, 1
	st r0, r1
	fi
	jsr WRITE_TO_FIELD
	jsr CHANGE_QUEUE_OF_PLAYER
	
	#загрузка id банки перехода
	ldi r0, 0x1e
	ld r0, r0
	br CHANGE
	#halt
asect 0xF7
	CHANGE:
	ldi r1, 0xff	
	st r1, r0
	br 0
end