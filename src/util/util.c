/*\
|*| C-Boil
|*| author
|*| C-Boil Utilities
\*/
/*\
|*| System Includes
\*/
#include <stdio.h>
/*\
|*| Project Includes
\*/
#include "../meta/meta.h"
#include "../cb.h"
#include "util.h"
/*\
|*| Implimentations
\*/
void
usage(char **argv)
{
	fprintf(stderr, "c-boil usage:\n");
	fprintf(stderr, "\t%s [-vcs] [config_file]\n", argv[0]);
}
void
version(char **argv)
{
	printf("%s version: %i.%i.%i\n",
		argv[0],
		cb_VERSION_MAJOR,
		cb_VERSION_MINOR,
		cb_VERSION_HOTFX
	);
}
