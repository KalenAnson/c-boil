# c-boil
Simple C Lang Boilerplate Project
## Details
Includes the requisite boilerplate code for getting a C project up and running using CMake as the build system.

The sample code should compile and run and provides the basic scaffolding needed to process command line arguments and structure a project.

## Dependancies
c-boil uses CMake as its build system. CMake can build for a wide variety of target systems including UNIX, Linux, OSX, and Windows. You might need to install cmake on your system:

### Debian / Ubuntu

	apt-get install cmake

### Others
Search for the cmake package using your package manager of choice or go to the CMake site and download the latest binary.

## Getting Started

1. Clone the c-boil project:

		git clone https://github.com/kalenanson/c-boil yourProjectDirectory
		cd yourProjectDirectory

2. At this point you can build the code as-is for a simple hello world example.

		# CMake uses out of tree builds, roll like this...
		mkdir build
		cd build
		cmake ..
		# Here you should see some text scrolling by that is generated as cmake
		# processes the 'CMakeLists.txt' cmake configuration file.
		make
		# Here make is running and compiling the sample project
		# You _could_ run make install at this point, but that would be dumb, as you
		# would get a pretty lame utility called cboil
		./cboil
		# You should have just seen the sample code execute and print some stuff.
		# Try the following for help
		./cboil -h
		# Check the version
		./cboil -v

## Taking Ownership of the Project
To begin writing your own code using the c-boil boilerplate do the following:

1. Remove any build files you may have created in the demo above, start at your project root directory:

		cd yourProjectDirectory
		rm -rfv build/*

2. Remove the c-boil repo stuff

		# This will remove the c-boil git directory and license, this is your project now!
		rm -rfv .git/ LICENSE

3. Rename the following files, here I am using the new project name 'derp'

		mv src/cb.c src/derp.c
		mv src/cb.h src/derp.h
		mv config/cboil.ini config/derp.ini
		mv config/cboil.log config/derp.log

4. Update the `CMakeLists.txt` file, start by changing all usages of the string 'cboil' to your desired binary's name, here derp. Here is a list of strings that you should change:

		cboil -> derp
		cb_ -> derp_
		CB_ -> DERP_

5. Update the section of the CMakeLists.txt file to point at the new source files renamed in step 3 above.

		add_executable(derp
			src/derp.c
			src/util/util.c
			src/skeleton/skeleton.c
		)

6. Apply the changes that you made in step 4 above to macro names in the following files:

		# src/meta/meta.h
		cb_* -> derp_*
		# src/meta/meta.h.in
		cb_* -> derp_*
		# src/util/util.c
		cb_* -> derp_*

7. Change the following include statements:

		# derp.c line 16
		#include "cb.h" -> #include "derp.h"
		# src/util/util.c line 14
		#include "../cb.h" -> #include "../derp.h"
		# src/skeleton/skeleton.c line 10
		#include "../cb.h" -> #include "../derp.h"

8. Look through the source files included in the `src` directory, In each file, make sure the instances of the string "C-Boil" are changed in comments.

9. Try a build now to make sure your project is properly renamed. If there are errors, address each before moving on:

		cd build
		cmake ..
		make
		./derp

Each of these commands should work as before, now creating the new binary 'derp' as our example.

10. Reinitialize your project git repo now that you have blown away the c-boil git directory.

		cd yourProjectDirectory
		git init
		git add .
		git commit -m "Initial Commit"
