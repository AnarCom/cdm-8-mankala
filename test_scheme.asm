asect 0x00
ldi r0, 0x0C

	ldi r1, 0x06
	sub r0, r1
	ldi r2, 0
	while 
		tst r1
	stays nz
	dec r2
	dec r2
	dec r1
	wend
halt
end.