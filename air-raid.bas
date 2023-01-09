5 poke36878,15
10 sc=0:hi=0:print"{clear}"
20 dimb$(4):d$="{space*22}"
30 a$=d$+"{black}{space*3}PO"+d$+"{left*5}{cm p}{cm o}{cm i}QQ{cm i}{cm o}{cm p}{space*10}"
40 b$(0)="{green}{reverse on}{space*2}UI{reverse off}{up}{left*5}{green}"
42 b$(1)="{green}{reverse on}{space*2}UI{down}{left*2}{sh -}{sh -}{reverse off}"
43 b$(3)="{green}{reverse on}N{cm t*4}M{down}{left*6}{cm g}{cm t*4}{cm m}{down}{left*6}L{cm @*4}{sh @}{reverse off}"
44 b$(2)="{green}{reverse on} U{sh asterisk*2}I{down}{left*4}{sh -}{space*2}{sh -}{reverse off}"
46 b$(4)="{green}{reverse on}{space*6}{down}{left*6}{space*6}{down}{left*6}{space*6}{reverse off}"
47 fort=0to8*22:poke8010+t,160:poke8010+t+30720,5:next
48 g=g+1:ifg>10then200
49 b=(int(rnd(1)*(21/5)+2)*5):poke36877,200
50 fort=0to4
52 dd=37154:p1=37151:p2=37152
54 pokedd,127:e=peek(p2)and128
56 j0=-(e=0)
58 pokedd,127:e=peek(p1)
60 j2=-((eand16)=0):fb=-((eand32)=0)
62 ifj0anda<(21-6)thena=a+4
63 ifj2anda>0thena=a-4
64 iffbthengosub100
66 print"{home}{red}score";sc;"{home}{down}";tab(a);a$:print"{down*13}"tab(b);b$(t)
95 fory=1to10:next
97 next
99 goto 48
100 c=a+3+7768
110 forx=cto(c+(22*16))step22
112 q1=peek(x):q2=peek(x+1)
120 pokex,95:pokex+30720,5:pokex+1,105:pokex+30721,5
121 ifq1=99+128orq2=128+99orq1=77+128orq2=77+128orq1=128+78orq2=78+128then140
122 pokex,q1:pokex+1,q2
130 next
132 pokex-22,160:pokex+1-22,160:pokex+1-22+30720,5:pokex-22+30720,5
135 return
140 sc=sc+10:poke36876,200:fory=1to100:next:poke36876,0
150 pokex,160:pokex+1,160:pokex+30720,5:poke37021,5
160 return
200 print"{clear}{blue}after passing 10{space*6}targets you scored:";sc
210 ifsc<1thenprint"have you seen your{space*4}doctor lately...you{space*3}have terrible reflexes"
212 ifsc>0andsc<60thenprint"not bad... if you weredead."
214 ifsc<90andsc>50thenprint"very good! next time{space*2}try to get it perfect"
216 ifsc>90 thenprint"{reverse on}perfect!!!!!!!!!!!!!!!congrats! pro!"
218 poke36877,0
