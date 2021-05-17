asect 0x00
START:
#rand char in r1

ldi r1, 0xFA
ld r1, r1

ldi r0, 0b00000111
and r0, r1

ldi r0, 6

if
	sub r1, r0
is pl
	br START
fi

ldi r0, 0x07
add r0, r1

ld r1, r2
if
tst r2
is z
	br START
fi

ldi r0, 0x10
add r0, r1

ld r1, r1

ldi r0, 0x1F
st r0, r1
ldi r0, 4
br CHANGE
asect 0xF7
	CHANGE:
	ldi r1, 0xff	
	st r1, r0
	br 0
end.