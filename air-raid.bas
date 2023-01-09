!- Variables:
!- B: random location for target
!- H: random height for target
!- TL: time limit
!- S: Speed
!- SL: speed loop.
!- A$: plane graphics
!- B$: [] of various target graphics (far to close)
!- T: for loop counter (used to loop through target graphics)
!- SC: Score
!- G: number of gates that passed by
!- A: plane location
!- P: target time delay to wait for.
!- DD: CIA location set joystick
!- P1: Joystick peek1
!- P2: Joystick peek2
!- E: Joystick peek value
!- J0: Flag joystick moved right
!- J2: flag joystick moved left
!- FB: flag firebutton hit.
!- C: bomb starting location
!- X: For loop bomb actual location.
!- Q1 and Q2: left and right peek valus at bomb's location
!- clear screen, inistialize graphcs, set volue
10 PRINT"{clear}":POKE8185,0:POKE38905,6
20 B=INT(RND(-1))
30 DIMB$(4):D$="{space*22}"
40 A$=D$+"{black}{space*3}PO"+D$+"{left*5}{cm p}{cm o}{cm i}QQ{cm i}{cm o}{cm p}{space*10}"
50 B$(0)="{green}{reverse on}{space*2}UI{reverse off}"
60 B$(1)="{green}{reverse on}{space*2}UI{down}{left*2}{sh -}{sh -}{reverse off}"
70 B$(3)="{green}{reverse on}N{cm t*4}M{down}{left*6}{cm g}{cm t*4}{cm m}{down}{left*6}L{cm @*4}{sh @}{reverse off}"
80 B$(2)="{green}{reverse on} U{sh asterisk*2}I{down}{left*4}{sh -}{space*2}{sh -}{reverse off}"
90 B$(4)="{green}{reverse on}{space*6}{down}{left*6}{space*6}{down}{left*6}{space*6}{reverse off}"
100 POKE36878,15
!- initialize variables, wait 1 second and wait for player to figure.
110 SC=0:A=0:PRINT"{clear}"
120 PRINT"{home}{down*15}{green}{reverse on}{space*175}{reverse off}{home}";
130 POKE8185,160:POKE8185+30720,5
140 P=TI+60
150 IF TI<P THEN 150
160 PRINT"{home}{down*6}{red}press fire..."
!- this wait waits for the firebutton to be pressed before escaping
170 WAIT 37137,32,32
!- main game loop.
180 TI$="000000":TL=TI+60*20:S=4:SC=0:PRINT"{home}{down*6}{green}{space*14}"
!- find location for gate
190 B=(INT(RND(1)*14))+1
200 H=(INT(RND(1)*2))
!- loop through all 5 gate animations.
210 FORT=0TO4
!- read the joystick and move the plane's position
220 FORSL=0toS:POKE36877,200-(S*3)
230 DD=37154:P1=37151:P2=37152
240 POKEDD,127:E=PEEK(P2)AND128
250 J0=-(E=0)
260 POKEDD,127:E=PEEK(P1)
270 J2=-((EAND16)=0):FB=-((EAND32)=0)
280 IFJ0ANDA<(21-8)THENA=A+3
290 IFA>14THENA=14
300 IFJ2ANDA>0THENA=A-3
310 IFA<0THENA=0
!- go to bombing subroutine
320 IFFBTHENGOSUB380
!- if out of time end the game
330 IFTI>TLTHEN510
!- print status bar, plane and target
340 PRINT"{home}{red}score";SC;"{home}{right*11}{black}time:";INT((TL-TI)/60);"{left}  {home}{down}";SPC(A);A$:PRINT"{home}{down*16}";SPC(B+(H*21));B$(T);
!- put in detay
350 FORY=1TO10:NEXT
!- finish sped loop and the animation loop
360 NEXT:NEXT
!- restart game loop for next gate.
370 GOTO 190
!- bombing subroutine
!- set bomb location to under middle of plane.
380 C=A+3+7768
!- loop from current location to bottom of screen.
390 FORX=CTO(C+(22*16))STEP22
!- look at bomb's location, should be limited to other parts.
400 Q1=PEEK(X):Q2=PEEK(X+1)
!- draw bom
410 POKEX,95:POKEX+30720,5:POKEX+1,105:POKEX+30721,5
!- if bomb hit parts of base, then go to hit subroutine (note: only last base has those values on line)
420 IFQ1=99+128ORQ2=128+99ORQ1=77+128ORQ2=77+128ORQ1=128+78ORQ2=78+128THEN470
!- erase bomb with same graphics that were underneath.
430 POKEX,Q1:POKEX+1,Q2
!- finish bombing run.
440 NEXT
!- end of bomb clean up and exit subroutine.
450 POKEX-22,160:POKEX+1-22,160:POKEX+1-22+30720,5:POKEX-22+30720,5
460 RETURN
!- bomb hit, inscrease score, add 10-S(peed) seconds and chime, cleanup and exit bomb subroutine
470 SC=SC+10:TL=TL+60*(8-S):POKE36876,200:FORY=1TO100:NEXT:POKE36876,0:IFINT((TL-TI)/60)>30THENTL=TI+30*60
!- T: for loop counter (used to loop through target graphics)
!- clean up after bomb, end sound, speed up when the score hits multiples of 100 (10 targets)
480 POKEX,160:POKEX+1,160:POKEX+30720,5:POKE37021,5:T=4:IFINT(SC/100)=SC/100THENS=S-1
490 IFS=-1THEN510
500 RETURN
!- end subroutine, different message based on score, put in a delay and allow for FB to be pressed in order to restart again.
510 PRINT"{clear}{blue}you scored:";SC
520 IFSC<1THENPRINT"have you seen your{space*4}doctor lately...you{space*3}have terrible reflexes"
530 IFSC>0ANDSC<100THENPRINT"not bad... if you weredead."
540 IFSC>90ANDSC<360THENPRINT"pretty good. aim higher."
550 IFSC<490ANDSC>350THENPRINT"very good! next time{space*2}try to get it perfect"
560 IFSC>490 THENPRINT"{reverse on}perfect!!!!!!!!!!!!!!!congrats! pro!{reverse off}"
570 POKE36877,0
580 P=TI+120
590 IF TI<P THEN 590
600 PRINT"{down}press fire to restart..."
610 WAIT 37137,32,32
620 GOTO 100