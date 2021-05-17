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
	rts
	
	CHANGE_QUEUE_OF_PLAYER:
	ldi r0, 0xFB
	ld r0, r0
	if
		tst r0
	is z
		ldi r0, 0x1E
		ld r0, r0
		dec r0
		dec r0
		if
			tst r0
		is z
			ldi r1, 3
		else
			ldi r1, 2
		fi
		ldi r0, 0x1E
		st r0, r1
	else
		ldi r0, 0xFB
		ldi r1, 0
		st r0, r1
	fi
	rts
	

	
MAIN: 
	ldi r0, 0x0E
	ld r0, r0
	#Память только была инициализирвоана?
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
