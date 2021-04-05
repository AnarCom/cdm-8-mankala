asect 0x00
jsr A
halt
A:
ldi r0, 0xff
ldi r1, 1
st r0, r1
rts
end
