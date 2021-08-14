# For CMake <= 3.12
target_sources(cboil
	PRIVATE
		${CMAKE_CURRENT_LIST_DIR}/meta.c
	PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/meta.h
)
