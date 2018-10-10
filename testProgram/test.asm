	processor	6502
	org	$1100
loop:
	inc	$900f
	jmp	loop
