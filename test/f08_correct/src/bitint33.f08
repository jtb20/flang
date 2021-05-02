!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! F2008 Compliance Tests: Bit-intrinsics test cases
!
! Date of Modification: Fri Apr 10 17:30:08 IST 2020
! Purpose: Test the operation of SHIFTR intrinsic
!
PROGRAM BITINT33
  IMPLICIT NONE
  INTEGER I
  INTEGER J
  INTEGER RESULT
  INTEGER SHIFT
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)

  I = INT(B'11100101')
  SHIFT = 2
  RESULT = SHIFTR(I, SHIFT)

  PRINT *, '------'
  PRINT *, 'SHIFT = ', SHIFT
  PRINT *, 'I = ', I
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I
  PRINT *, 'RESULT = ', RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'00111001')) THEN
    PRINT *, 'EXPECTED = ', INT(B'00111001')
    PRINT '(B8.8)', INT(B'00111001')
    PRINT *, "FAIL-1"
    !STOP "FAIL-1"
  ELSE
    PRINT *, "PASS-1"
  END IF

  SHIFT = 5
  RESULT = SHIFTR(I, SHIFT)

  PRINT *, '------'
  PRINT *, 'SHIFT = ', SHIFT
  PRINT *, 'I = ', I
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I
  PRINT *, 'RESULT = ', RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'00000111')) THEN
    PRINT *, 'EXPECTED = ', INT(B'00000111')
    PRINT '(B8.8)', INT(B'00000111')
    PRINT *, "FAIL-2"
    !STOP "FAIL-2"
  ELSE
    PRINT *, "PASS-2"
  END IF

  I = INT(B'01100101')
  SHIFT = 2
  RESULT = SHIFTR(I, SHIFT)

  PRINT *, '------'
  PRINT *, 'SHIFT = ', SHIFT
  PRINT *, 'I = ', I
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I
  PRINT *, 'RESULT = ', RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'00011001')) THEN
    PRINT *, 'EXPECTED = ', INT(B'00011001')
    PRINT '(B8.8)', INT(B'00011001')
    PRINT *, "FAIL-3"
    !STOP "FAIL-3"
  ELSE
    PRINT *, "PASS-3"
  END IF

  SHIFT = 5
  RESULT = SHIFTR(I, SHIFT)

  PRINT *, '------'
  PRINT *, 'SHIFT = ', SHIFT
  PRINT *, 'I = ', I
  PRINT '(B8.8)', I
  WRITE(UNIT=*,FMT="(B32.32)") I
  PRINT *, 'RESULT = ', RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'00000011')) THEN
    PRINT *, 'EXPECTED = ', INT(B'00000011')
    PRINT '(B8.8)', INT(B'00000011')
    PRINT *, "FAIL-4"
    !STOP "FAIL-4"
  ELSE
    PRINT *, "PASS-4"
  END IF

  J = -27
  ! 1111,1111,1111,1111,1111,1111,1110,0101
  SHIFT = 2
  RESULT = SHIFTR(J, SHIFT)

  PRINT *, '------'
  PRINT *, 'SHIFT = ', SHIFT
  PRINT *, 'J = ', J
  PRINT '(B8.8)', J
  WRITE(UNIT=*,FMT="(B32.32)") J
  PRINT *, 'RESULT = ', RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'00111111111111111111111111111001')) THEN
    PRINT *, 'EXPECTED = ', INT(B'00111111111111111111111111111001')
    PRINT '(B8.8)', INT(B'00111111111111111111111111111001')
    PRINT *, "FAIL-5"
    !STOP "FAIL-5"
  ELSE
    PRINT *, "PASS-5"
  END IF

  SHIFT = 5
  RESULT = SHIFTR(J, SHIFT)

  PRINT *, '------'
  PRINT *, 'SHIFT = ', SHIFT
  PRINT *, 'J = ', J
  PRINT '(B8.8)', J
  WRITE(UNIT=*,FMT="(B32.32)") J
  PRINT *, 'RESULT = ', RESULT
  PRINT '(B8.8)', RESULT
  WRITE(UNIT=*,FMT="(B32.32)") RESULT

  IF (RESULT /= INT(B'00000111111111111111111111111111')) THEN
    PRINT *, 'EXPECTED = ', INT(B'00000111111111111111111111111111')
    PRINT '(B8.8)', INT(B'00000111111111111111111111111111')
    PRINT *, "FAIL-6"
    !STOP "FAIL-6"
  ELSE
    PRINT *, "PASS-6"
  END IF
  CALL CHECK(RES, EXP, N)
END PROGRAM