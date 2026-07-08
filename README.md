# Frescox
Scattering code Frescox for coupled-channels calculations

FRESCOX   FRXY version 7.3 at https://github.com/LLNL/Frescox 

LLNL-CODE-811517


This directory contains four sub-directories: source, man, test and util.

The source/ directory contains : Fortran files *.f,
                                 fx*.def files for separate machines

  File nagstub.f in the case you do not have the nag library locally.

The test/   directory contains : at least 6 test jobs xeta, lane20 & f19xfr,
                                             e80f49b, on2 & be11


The man/   directory contains the instruction manual in latex:
                      frescox-input-manual.tex: latex source 
                      frescox-input-manual.pdf: printable output
More documentation is at http://www.fresco.org.uk/documentation.htm

To compile FRESCOX,
 
   1) Enter frxy/source, and then edit the makefile for your target machine,
	by setting the MACH variable as appropriate (either in the makefile
		or in our local shell setup),
	by choosing the file nagstub.f if the NAG library not available
	
	The script 'mk' attempts to guess the correct MACH settings
	for ordinary frescox version AND compile in a corresponding subdirectory.

   2) Set up ~/binw/`a=rch` to point to directory for storing the binary

   3) Copy your aliases to e.g. ~/.fresco.aliases
      Edit FRESCOXLIB according to 2) above
      Execute .fresco.aliases e.g. in .cshrc  by including:	
        source ~/.fresco.aliases

If you are to install frescox yourself in a standard bin directory, 
       then steps 3 and 4 may be omitted, and step 2' performed manually.

 If your compiler is gfortran, for example, then:
   2') Compile the subroutines required by:
        
		mk gfortran
        make MACH=gfortran

   4) Install, to copy `frescox' to the FRESCOXLIB.
        make MACH=gfortran install

   5) Clean up, with:	
        make clean

To compile parallel versions:

	1) There 4 options for run-time scripts that  follow binary name;
 
    frescox_all:         serial     frescox
    frescom_mpi_all:     MPI        frescom
    frescoo_op_all :     OpenMP     frescoo
    frescoom_op_mpi_all: MPI and OpenMP frescoom
 
	2) To compile in the source/ directory, run
 
		mk  <compiler>-<parallels> -j 10 install
 
		where
			<compiler> = intel or gfortran
			<parallels> = mpi or mpich or openmp or op+mpi
 
		The ‘mk’ script looks for all the compilation options 
		in file fx<compiler>-<parallels>.def and builds in 
		directory <compiler>-<parallels>/

  
To run FRESCOX,

   1) Enter test/ directory.

   2) The scripts include commands to construct temporary 'data' files. 
	These scripts are run by just saying  e.g.
           frescox < lane20.nin > lane20.out
        See file 'do-all.bat' to run all the test cases

   3) In the test/legacy directory there are executable 'job' run scripts
      To save the output in a file .e.g. `out', run the scripts by
       lane20.job > out &
         or simply (using the 'run' command in the 'aliases' file):;
       run lane20.job 
         to use input file lane20.job and produce output file lane20.out.

   4) To save any other output files from frescox, e.g. fort.16 for 
      cross sections, 
         touch lane20.xsecs
         ln -s lane20.xsecs fort.16
      before running frescox.
      The file fort.16 may have to be called for016.dat on some machines.

Please let me know if you have any questions or problems:
    
   I.Thompson@fresco.org.uk

Cheers, Ian Thompson
July 2025

