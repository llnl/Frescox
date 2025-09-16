!***********************************************************************
! 
!    Copyright 2025, I.J. Thompson
!
!    This file is part of FRESCOX.
!
!    FRESCOX is free software; you can redistribute it and/or
!    modify it under the terms of the GNU General Public License
!    as published by the Free Software Foundation; either version 2
!    of the License, or (at your option) any later version.
!    
!    This program is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!    
!    You should have received a copy of the GNU General Public License
!    along with this program; if not, write to the Free Software
!    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
!    MA  02110-1301, USA.
!
!    OUR NOTICE AND TERMS AND CONDITIONS OF THE GNU GENERAL PUBLIC
!    LICENSE
!
!    The precise terms and conditions for copying, distribution and
!    modification are contained in the file COPYING.
!
!***********************************************************************

       real,allocatable:: RL(:)
       complex,allocatable:: FORM(:)
       integer PTYPE(8),TYPE,TAU,DIR
       character*32 COMMENT

        open(4,file='Kind0.forms')
        READ(5,'(1x,f8.5)',END=200) HCM
C       print *,'HCM=',HCM

        M = 0

        if (HCM<1e-5) go to 200
10        READ(5,'(1x,4i5,f8.5)') MP,MATCH,MR,I
       if (MP==0) go to 200
       NLN = (MATCH-1)/MR + 1 
C      print *,'M,MP,NLN=',MP,M,NLN
        M = M+1
       if(M==1) then
         allocate(FORM(NLN),RL(NLN))
         endif
        READ(5,140) (PTYPE(I),I=1,3),(PTYPE(I),I=7,8)
140     format(23x,i3,18x,2i3,5x,i1,5x,i1)
        WRITE(6,141) (PTYPE(I),I=1,3),(PTYPE(I),I=7,8)
141     format('# Optical potential KP=',i3,': type,multipole =',2i3,
     x         ' TAU=',i1,' DER=',i1)

       DO 83 I=1,NLN
       READ(5,144) RL(I),FORM(I)
144    FORMAT(1X,F8.3,2e13.5)
83     continue

       READ(5,*) 
C  Prepare data for fort.4 format with KIND=0  
C    ELASTIC SCATTERING ONLY FOR NOW
       NP = NLN
       HNP = HCM*MR
       RFS = RL(1)
       FSCALE = 1.0
       TYPE = PTYPE(2)
       k =    PTYPE(3)
       TAU =  PTYPE(7)
       DER =  PTYPE(8)
       IB = 1
       IA = 1
       IT = 0
       COMMENT = 'from fort.89 of p-cd-cc4'

C      WRITE(6,219) NP,HNP,RFS,FSCALE,TYPE,k,TAU,DIR,IT,IB,IA,COMMENT
       WRITE(4,219) NP,HNP,RFS,FSCALE,TYPE,k,TAU,DIR,IT,IB,IA,COMMENT
219   FORMAT(I4,3F8.4,7I4,A32)
       write(4,232) FORM(1:NP)
232    format(1p,6e12.4)

       go to 10

200    stop
       end