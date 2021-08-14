#!/bin/bash
if [[ -z $1 ]]; then
	echo "Please specify the name of the new sub directory"
	exit 1
fi
name="$1"
path="src/${name}"
if [[ -d "$path" ]]; then
	echo "Path [${path}] already exists"
	exit 1
fi
if [[ ! -d "src/skeleton" ]]; then
	echo "Unable to locate skeleton directory"
	exit 1
fi
cp -R "src/skeleton" "$path"
if [[ $? -ne 0 ]]; then
	echo "Unable to copy new directory"
	exit 1
fi
mv "${path}/skeleton.c" "${path}/${name}.c"
mv "${path}/skeleton.h" "${path}/${name}.h"
if [[ "$OSTYPE" == "darwin"* ]]; then
	sed -i '' -e "s/skeleton/${name}/g" "${path}/${name}.c"
	sed -i '' -e "s/skeleton/${name}/g" \
		-e "s/SKELETON/${name^^}/g" \
		"${path}/${name}.h"
	sed -i '' -e "s/skeleton/${name}/g" "${path}/CMakeLists.txt"
	sed -i '' -e "/^#ADD_SUB_DIRS/iadd_subdirectory(${path})" CMakeLists.txt
else
	sed -i -e "s/skeleton/${name}/g" "${path}/${name}.c"
	sed -i -e "s/skeleton/${name}/g" \
		-e "s/SKELETON/${name^^}/g" \
		"${path}/${name}.h"
	sed -i -e "s/skeleton/${name}/g" "${path}/CMakeLists.txt"
	sed -i -e "/^#ADD_SUB_DIRS/iadd_subdirectory(${path})" CMakeLists.txt
fi
echo "New subdirectory created: [${path}]"
