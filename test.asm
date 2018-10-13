;Test programs CPSC 599.82
;	1.		Flash the screen by changing the Screen and border color register
;	2.		Print out "HELLO WORLD!" on the screen
;	3.		Get input characters from the keyboard and output on the screen
;	4.		Print character "X" at a user specified position (enter x then y)
;	5.		Output one note continuously
;	6.		Beep intermidently up a scale (pause between each note)
;	7.		Test gravity effect, have one ascii character fall at one constant speed until it 'hits' a floor
;	8.		Accelerating gravity effect
;	9.		Move ascii character around randomly (smooth discrete movement along coordinate grids)
;	10.		Move ascii character around with w, a, s and d keys







;=============================    TO DO    =============================
;Fix test 4
;Implement test 6
;Implement test 7
;Implement test 8
;Implement test 9
;Implement test 10
















;==============================================================
;Start of the test programs
	processor	6502 ;pseudo code for dasm to indicate
	org	$1100        ;Start point of this program in the memory (4352 in decimal)

;START WHICH TEST? (Just for now, there is another way to switch the routines)
	jmp	test4

;============================================================
;Test10
;Move ascii character around with w, a, s and d keys
;simulate player movement
test10:
	jmp	donetest


;============================================================
;Test9
;Move ascii character around randomly (smooth discrete movement along coordinate grids)
;simulate non-player character movement
test9:
	jmp	donetest


;============================================================
;Test8
;Accelerated gravity effect
test8:
	jmp	donetest


;============================================================
;Test7
;Test gravity effect, have one ascii character fall at one constant speed until it 'hits' a floor
test7:
	jmp	donetest


;============================================================
;Test6
;Beep intermidently up a scale (pause between each note)
;tests timing and use of different musical notes
test6:
	jmp	donetest


;============================================================
;Test5
;Output one note continuously
test5:
	lda #15		;volume set to level 15 (volume is in 0-15)
	sta	$900e	;memory location of volume
	lda	#201	;Represents a D note
	sta	$900c	;high speaker
	jmp	test5


;==============================================================
;Test 4
;Print character "X" at a user specified position (enter x then y)
;
test4:
	jsr $e55f	; clear screen
getx:
	lda #$0		; reset accumulator
	jsr	$ffe4;	; get user to enter a character
	cmp $00		; if no character (x position) has been entered
	beq getx
	sbc $30		; decrement user ascii character by $30 => user entered 5 then A now stores 5, user entered 2 then A now stores 2 etc...
	adc	$D3		; $D3 is cursor position on line
gety:
	lda #$0		; reset accumulator
	jsr	$ffe4;	; get user to enter a character
	cmp $00		; if no character (x position) has been entered
	beq gety
	sbc $30		; decrement user ascii character by $30 => user entered 5 then A now stores 5, user entered 2 then A now stores 2 etc...
	tax			; transfer registers A to X
	lda #21
addlines:
	adc	$D3		; $D3 is cursor position on line
	dex
	bne addlines
linesadded:
	adc	$D3		; $D3 is cursor position on line
	lda $D5		; current line length
	sta $D3
	lda #$40
	jsr	$ffd2
	jmp	donetest

;=============================================================
;Test 3
;Get input characters from the keyboard and output on the screen
test3:
	jsr $e55f	; clear screen
mylabel:
	jsr	$ffe4	;could change to $ffcf, but got problem when press enter key
	jsr	$ffd2
	jmp	mylabel

;==============================================================
;Test 2
;Print out "HELLO WORLD!" on the screen
;test display
;CHROUT $ffd2, Output character to channel
test2:
	jsr	$e55f
	lda	#'H	;H
	jsr	$ffd2
	lda	#'E	;E
	jsr	$ffd2
	lda	#'L	;L
	jsr	$ffd2
	lda	#'L	;L
	jsr	$ffd2
	lda	#'O	;O
	jsr	$ffd2
	lda	#' 	;space
	jsr	$ffd2
	lda	#'W	;W
	jsr	$ffd2
	lda	#'O	;O
	jsr	$ffd2
	lda	#'R	;R
	jsr	$ffd2
	lda	#'L	;L
	jsr	$ffd2
	lda	#'D	;D
	jsr	$ffd2
	lda	#'!	;!
	jsr	$ffd2
	jmp	donetest

;=====================================================
;Test 1
;Flash the screen by changing the Screen and border color register
test1:
	inc	$900f
	jmp	test1

donetest:
	jmp donetest