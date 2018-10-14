;Test programs CPSC 599.82

;	when run this program 

;	1.		Flash the screen by changing the Screen and border color register
;	2.		Print out "HELLO WORLD!" on the screen
;	3.		Get input characters from the keyboard and output on the screen
;	4.		Print character "X" at a user specified position (enter x then y)
;	5.		Output one note continuously
;	6.		Beep intermidently up a scale (pause between each note)
;	7.		Test gravity effect, have one ascii character fall at one constant speed until it 'hits' a floor
;	8.		Accelerating gravity effect
;	9.		Move ascii character around randomly (smooth discrete movement along coordinate grids)
;	0.		Move ascii character around with w, a, s and d keys







;=============================    TO DO    =============================
;Fix test 4
;Implement test 6
;Implement test 7
;Implement test 8
;Implement test 9
;Implement test 0
















;==============================================================
;Start of the test programs
	processor 6502	;pseudo code for dasm to indicate
	org	$1100		;Start point of this program in the memory (4352 in decimal)

	jsr $e55f		; clear screen, then prompt user
	; lda	#'E
	; jsr	$ffd2
	; lda	#'N
	; jsr	$ffd2
	; lda	#'T
	; jsr	$ffd2
	; lda	#'E
	; jsr	$ffd2
	; lda	#'R
	; jsr	$ffd2
	; lda	#' 	
	; jsr	$ffd2
	; lda	#'A
	; jsr	$ffd2
	; lda	#' 
	; jsr	$ffd2
	; lda	#'T
	; jsr $ffd2
	; lda	#'E	
	; jsr	$ffd2
	; lda	#'S
	; jsr	$ffd2
	; lda	#'T
	; jsr	$ffd2
	; lda	#' 
	; jsr	$ffd2
	; lda	#'N
	; jsr	$ffd2
	; lda	#'U
	; jsr	$ffd2
	; lda	#'M
	; jsr	$ffd2
	; lda	#'B	
	; jsr	$ffd2
	; lda	#'E	
	; jsr	$ffd2
	; lda	#'R
	; jsr	$ffd2
	; lda	#' 
	; jsr	$ffd2
	; lda	#'(
	; jsr	$ffd2
	; lda	#'0	
	; jsr	$ffd2
	; lda	#'-	
	; jsr	$ffd2
	; lda	#'9
	; jsr	$ffd2
	; lda	#')
	; jsr	$ffd2
	; lda #':
	; jsr $ffd2
	; lda #'
	; jsr $ffd2
	jmp test6

getTest:
	; lda #0
	; jsr	$ffe4		;accept user input for test number 
	; cmp #0
	; beq getTest		;loop back up, user hasn't entered a test yet
	; tax				;user entered number is in x now
	; inx				;sets up test number correctly
	; jmp test9		;test 9 will compare x to test # to see if it should execute, pass execution on if not
	lda #0
	jsr $ffe4
	tax
	inx
	jsr $ffd2 
	jmp getTest

;============================================================
;Test9
;Move ascii character around randomly (smooth discrete movement along coordinate grids)
;simulate non-player character movement
test9:
	dex
	cpx #$39		;check if user entered 9
	bne test8
	jmp	donetest9
donetest9:
	jmp donetest9	;is an infinite loop. Will be reached when user selected test is complete


;============================================================
;Test8
;Accelerated gravity effect
test8:
	dex
	cpx #$38		;check if user entered 8
	bne test7
	jmp	donetest8
donetest8:
	jmp donetest8	;is an infinite loop. Will be reached when user selected test is complete


;============================================================
;Test7
;Test gravity effect, have one ascii character fall at one constant speed until it 'hits' a floor. It falls 13 lines at a speed of 500ms. In order to see it clearly 
;user should set the speed at 10-20%
test7:
	; dex
	; cpx #$37		;check if user entered 7
	; bne test6
	; jmp	donetest7
	ldx #0							;x = 0
	lda #9							
	sta $D3							; D3 = 9 = middle of the screen
	lda #'D							; print letter D
	jsr $ffd2
	jmp test7loop					;go to test7loop
waitLoop:							;a waitLoop of 500ms
	iny
	cpy $200
	bne waitLoop
	ldy $0
secondLoop:
	iny
	cpy $200
	bne	secondLoop
	ldy $0
thirdLoop:
	iny
	cpy $200
	bne thirdLoop
	ldy $0
fourthLoop:
	iny
	cpy $200
	bne fourthLoop
	ldy $0
fifthLoop:
	iny 
	cpy $200
	bne fifthLoop
test7loop:
	inx
	cpx #13				;compare x with 13, aka falling down 13 lines
	beq donetest7
	dec $D3				
	lda #'				;erase what has just been printed
	jsr $ffd2
	lda #21				
	adc $D1				;add 21 into D1 to go to the next line
	sta $D1				;store it into D1
	lda #'D				;print D again
	jsr $ffd2
	ldy #0
	jmp waitLoop		;go to 500ms waitLoop
donetest7:
	jmp donetest7	;is an infinite loop. Will be reached when user selected test is complete


;============================================================
;Test6
;Beep intermidently up a scale (pause between each note)
;tests timing and use of different musical notes
test6:
	; dex
	; cpx #$36		;check if user entered 6
	; bne test5
	; jmp	donetest6
	ldx #0
	stx $900e
	ldy #0
	lda $135
	sta $900c
	jmp test6Note
test6waitLoop:							;a waitLoop of 500ms
	iny
	cpy $200
	bne test6waitLoop
	ldy $0
test6secondLoop:
	iny
	cpy $200
	bne	test6secondLoop
	ldy $0
test6thirdLoop:
	iny
	cpy $200
	bne test6thirdLoop
	ldy $0
test6fourthLoop:
	iny
	cpy $200
	bne test6fourthLoop
	ldy $0
test6fifthLoop:
	iny 
	cpy $200
	bne test6fifthLoop
test6Note:
	lda #1					
	adc $900e
	sta $900e					;increment the volume at its address by 1
	lda #2						
	adc $900c
	sta	$900c					;increase the note by 2 
	jmp test6waitLoop
	
donetest6:
	jmp donetest6	;is an infinite loop. Will be reached when user selected test is complete


;============================================================
;Test5
;Output one note continuously
test5:
	dex
	cpx #$35		;check if user entered 5
	bne test4
	lda #15		;volume set to level 15 (volume is in 0-15)
	sta	$900e	;memory location of volume
	lda	#201	;Represents a D note
	sta	$900c	;high speaker
	jmp	test5


;==============================================================
;Test 4
;Print character "X" at a user specified position (enter x then y)
test4:
	dex
	cpx #$34		;check if user entered 4
	bne test3
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
	jmp	donetest4
donetest4:
	jmp donetest4	;is an infinite loop. Will be reached when user selected test is complete

;=============================================================
;Test 3
;Get input characters from the keyboard and output on the screen
test3:
	dex
	cpx #$33		;check if user entered 3
	bne test2
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
	dex
	cpx #$32		;check if user entered 2
	bne test1
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
	jmp	donetest2
donetest2:
	jmp donetest2	;is an infinite loop. Will be reached when user selected test is complete

;=====================================================
;Test 1
;Flash the screen by changing the Screen and border color register
test1:
	dex
	cpx #$31		;check if user entered 1
	bne test0
	inc	$900f
	jmp	test1

;============================================================
;Test0
;Move ascii character around with w, a, s and d keys
;simulate player movement
test0:
	jmp	donetest0

donetest0:
	jmp donetest0	;is an infinite loop. Will be reached when user selected test is complete
