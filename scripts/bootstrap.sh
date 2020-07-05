#!/bin/bash
# C-Boil Bootstrap script
cwd="$(pwd)"
if [[ $? -ne 0 ]]; then
	echo "Unable to determine working directory"
	exit 1
fi
if [[ ! -f "${cwd}/scripts/bootstrap.sh" ]]; then
	cd ..
	if [[ $? -ne 0 ]]; then
		echo "Unable to change working directory"
		exit 1
	fi
	cwd="$(pwd)"
	if [[ $? -ne 0 ]]; then
		echo "Unable to determine working directory after change"
		exit 1
	fi
	if [[ ! -f "${cwd}/scripts/bootstrap.sh" ]]; then
		echo "Invalid working directory [${cwd}]"
		echo "Please rerun this script from your project directory"
		exit 1
	fi
fi
# Variables
target=""
project_name=""
macro=""
if [[ ! -z "$1" ]]; then
	project_name="$1"
	target="$1"
	macro="$1"
fi
echo "Bootstrapping project"
if [[ -z "$project_name" ]]; then
	echo "> Please enter a project name (one word, no spaces)"
	read -p "(project name) " project_name
	if [[ -z "$project_name" ]]; then
		echo "A valid project name is manditory"
		exit 1
	fi
	echo "Project name: [${project_name}]"
	echo "> Is this correct?"
	read -p "(Y,n) " confirm
	if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
		echo "Bootstrap aborted"
		exit 1
	fi
	echo "> Is the build target the same as the project name?"
	read -p "(Y,n) " confirm
	if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
		echo "> Please enter the build target name / binary name"
		read -p "(target) " target
		if [[ -z "$target" ]]; then
			echo "A valid target name is manditory"
			exit 1
		fi
		echo "Target name: [${target}]"
		echo "> Is this correct?"
		read -p "(Y,n) " confirm
		if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
			echo "Bootstrap aborted"
			exit 1
		fi
	else
		target="$project_name"
	fi
	echo "> Please enter a header macro project alias (all upper case, one word)"
	read -p "(MACRO) " macro
	if [[ -z "$macro" ]]; then
		echo "A valid macro name is manditory"
		exit 1
	fi
	echo "Macro alias: [${macro}]"
	echo "> Is this correct?"
	read -p "(Y,n) " confirm
	if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
		echo "Bootstrap aborted"
		exit 1
	fi
fi
if [[ -z "$cwd" ]]; then
	echo "Invalid working directory"
	exit 1
fi
echo " "
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "Project Name: [$project_name]"
echo "Build Target: [$target]"
echo "Project Directory: [${cwd}]"
echo "Macro Alias: [${macro}]"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo " "
echo "!!! Caution: Bootstrapping will reset git history and make permanent changes !!!"
echo "> @@@ Proceed with bootstrap? @@@"
read -p "(y,N) " confirm
if [[ -z "$confirm" || "$confirm" == "n" || "$confirm" == "N" ]]; then
	echo "Bootstrap aborted"
	exit 1
fi
echo "Bootstrapping project"
if [[ -d "${cwd}/build" ]]; then
	echo " * Removing build directory"
	rm -rf "${cwd}/build"
fi
if [[ -d "${cwd}/.git" ]]; then
	echo " * Removing git directory"
	rm -rf "${cwd}/.git"
fi
if [[ -f "${cwd}/LICENSE" ]]; then
	echo " * Removing license"
	rm -rf "${cwd}/LICENSE"
fi
echo " * Renaming source files"
mv src/cb.c "src/${project_name}.c"
mv src/cb.h "src/${project_name}.h"
mv config/cboil.ini "config/${project_name}.ini"
mv config/cboil.log "config/${project_name}.log"
echo "Updating CMakeLists.txt file"
if [[ "$OSTYPE" == "darwin"* ]]; then
	sed -i '' -e "s/cboil/${target}/g" \
		-e "s/cb_/${target}_/g" \
		-e "s/cb\.c/${project_name}\.c/g" \
		CMakeLists.txt
	sed -i '' -e "s/cb_/${target}_/g" src/meta/meta.h
	sed -i '' -e "s/cb_/${target}_/g" src/meta/meta.h.in
	sed -i '' -e "s/cb_/${target}_/g" src/util/util.c
	sed -i '' -e "s/cb\.h/${project_name}\.h/g" "src/${project_name}.c"
	sed -i '' -e "s/cb\.h/${project_name}\.h/g" "src/util/util.c"
	sed -i '' -e "s/cb\.h/${project_name}\.h/g" "src/skeleton/skeleton.h"
	find . -type f -exec sed -i '' -e "s/C-Boil/${project_name}/g" {} +
	find . -type f -exec sed -i '' -e "s/c-boil/${project_name}/g" {} +
	find . -type f -exec sed -i '' -e "s/CB_/${macro}_/g" {} +
else
	sed -i -e "s/cboil/${target}/g" \
		-e "s/cb_/${target}_/g" \
		-e "s/cb\.c/${project_name}\.c/g" \
		CMakeLists.txt
	sed -i "s/cb_/${target}_/g" src/meta/meta.h
	sed -i "s/cb_/${target}_/g" src/meta/meta.h.in
	sed -i "s/cb_/${target}_/g" src/util/util.c
	sed -i "s/cb\.h/${project_name}\.h/g" "src/${project_name}.c"
	sed -i "s/cb\.h/${project_name}\.h/g" "src/util/util.h"
	sed -i "s/cb\.h/${project_name}\.h/g" "src/skeleton/skeleton.h"
	find . -type f -exec sed -i "s/C-Boil/${project_name}/g" {} +
	find . -type f -exec sed -i "s/c-boil/${project_name}/g" {} +
	find . -type f -exec sed -i "s/CB_/${macro}_/g" {} +
fi
echo "Bootstrapping complete"
exit 0
