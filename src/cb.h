/******************************************************************************\
|*| C-Boil
|*| author
|*| C-Boil Main Header
\******************************************************************************/
#ifndef CB_MAIN_H
#define CB_MAIN_H
/******************************************************************************\
|*| System Includes
\******************************************************************************/
#include <stddef.h>
/******************************************************************************\
|*| Project Includes
|*| The "../build/config.h" here gives access to compile time macros from CMake
\******************************************************************************/
#include "../build/config.h"
/******************************************************************************\
|*| Conditional Macros
|*|
|*| Build time macros that control some aspects of our project - these are read
|*| from "../build/config.h" which is templated in "config.h.in" and set in the
|*| "CMakeLists.txt" file
\******************************************************************************/
/*\
|*| Define derpFoo() if it does not exist in some.h
\*/
#ifndef CB_D_VARIABLE
size_t derpFoo (const char *, size_t);
#endif /* CB_D_VARIABLE */
/******************************************************************************\
|*| C-Boil Project Macros
\******************************************************************************/
#define CB_CONFIG_OPTION_1 \
	0x01				/* Option 1											*/
#define CB_CONFIG_OPTION_2 \
	0x02				/* Option 2											*/
#define CB_CONFIG_OPTION_3 \
	0x04				/* Option 3											*/
#define CB_CONFIG_OPTION_4 \
	0x08				/* Option 4											*/
/******************************************************************************\
|*| C-Boil Utility Macros
\******************************************************************************/
#define	min(a,b)	((a) < (b) ? (a) : (b))
#define	max(a,b)	((a) > (b) ? (a) : (b))
/******************************************************************************\
|*| C-Boil Project Global Variables
\******************************************************************************/
/*\
|*| cbActive description
\*/
extern short cbActive;
/******************************************************************************\
|*| C-Boil Variable Declarations
\******************************************************************************/
/*\
|*| The block struct is a generic struct for illustration here.
\*/
struct block {
	int		valid;		/* Member to indicate that this struct is good		*/
	char 	*name;		/* The struct name									*/
};
#endif /* CB_MAIN_H */
