FUNCTION PRINT_CAL(YEAR)
  LOCAL MONTHS={"JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE",
                "JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"}
  LOCAL DAYSTITLE="MO TU WE TH FR SA SU"
  LOCAL DAYSPERMONTH={31,28,31,30,31,30,31,31,30,31,30,31}
  LOCAL STARTDAY=((YEAR-1)*365+MATH.FLOOR((YEAR-1)/4)-MATH.FLOOR((YEAR-1)/100)+MATH.FLOOR((YEAR-1)/400))%7
  IF YEAR%4==0 AND YEAR%100~=0 OR YEAR%400==0 THEN
    DAYSPERMONTH[2]=29
  END
  LOCAL SEP=5
  LOCAL MONTHWIDTH=DAYSTITLE:LEN()
  LOCAL CALWIDTH=3*MONTHWIDTH+2*SEP

  FUNCTION CENTER(STR, WIDTH)
    LOCAL FILL1=MATH.FLOOR((WIDTH-STR:LEN())/2)
    LOCAL FILL2=WIDTH-STR:LEN()-FILL1
    RETURN STRING.REP(" ",FILL1)..STR..STRING.REP(" ",FILL2)
  END

  FUNCTION MAKEMONTH(NAME, SKIP,DAYS)
    LOCAL CAL={
      CENTER(NAME,MONTHWIDTH),
      DAYSTITLE
    }
    LOCAL CURDAY=1-SKIP
    WHILE #CAL<9 DO
      LINE={}
      FOR I=1,7 DO
        IF CURDAY<1 OR CURDAY>DAYS THEN
          LINE[I]="  "
        ELSE
          LINE[I]=STRING.FORMAT("%2D",CURDAY)
        END
        CURDAY=CURDAY+1
      END
      CAL[#CAL+1]=TABLE.CONCAT(LINE," ")
    END
    RETURN CAL
  END

  LOCAL CALENDAR={}
  FOR I,MONTH IN IPAIRS(MONTHS) DO
    LOCAL DPM=DAYSPERMONTH[I]
    CALENDAR[I]=MAKEMONTH(MONTH, STARTDAY, DPM)
    STARTDAY=(STARTDAY+DPM)%7
  END


  PRINT(CENTER("[SNOOPY]",CALWIDTH):UPPER(),"\N")
  PRINT(CENTER("--- "..YEAR.." ---",CALWIDTH):UPPER(),"\N")

  FOR Q=0,3 DO
    FOR L=1,9 DO
      LINE={}
      FOR M=1,3 DO
        LINE[M]=CALENDAR[Q*3+M][L]
      END
      PRINT(TABLE.CONCAT(LINE,STRING.REP(" ",SEP)):UPPER())
    END
  END
END

PRINT_CAL(1969)