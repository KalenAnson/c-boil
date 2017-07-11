/******************************************************************************\
|*| C-Boil
|*| author
|*| C-Boil Main
\******************************************************************************/
/******************************************************************************\
|*| C-Boil System Includes
\******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
/******************************************************************************\
|*| C-Boil Project Includes
\******************************************************************************/
#include "cb.h"
#include "util/util.h"
#include "skeleton/skeleton.h"
/******************************************************************************\
|*| C-Boil Conditional Statements
\******************************************************************************/
#ifndef CB_D_VARIABLE
size_t
derpFoo (const char *s, size_t maxlen)
{
    size_t i;
    for (i = 0; i < maxlen; ++i)
        if (s[i] == '\0')
            break;
    return i;
}
#endif /* CB_D_VARIABLE */
/*\
|*| External varaibles
\*/
short cbActive = 0;
/*\
|*| Implimentation
\*/
int
main(int argc, char **argv, char **envp)
{
	/*\
	|*| Main Variables
	\*/
	int opt;
	int foo;
	char *config_file;
	/*\
	|*| Parse arguments
	\*/
	config_file = NULL;
	while ( (opt = getopt(argc, argv, "h?vf:") ) != -1) {
		switch (opt) {
			case 'h':
			case '?':
				usage(argv);
				exit(EXIT_SUCCESS);
				break;
			case 'v':
				version(argv);
				exit(EXIT_SUCCESS);
				break;
			case 'f':
				config_file = optarg;
				break;
			default:
				usage(argv);
				exit(EXIT_FAILURE);
		}
	}
	/**************************************************************************\
	|*| @NOTE
	|*| At this point 'optind' (declared extern int by <unistd.h>) is the index
	|*| of the first non-option argument
	|*| If optind is >= argc, there were no non-option arguments.
	\**************************************************************************/
	/*\
	|*| Do stuff
	\*/
	if (config_file == NULL) {
		config_file = "config/default.ini";
	}
	foo = 41;
	printf("C-Boil Config File [%s]\n", config_file);
	printf("Foo: %i, %i\n", foo, skeleton(foo) );
	exit(EXIT_SUCCESS);
}
