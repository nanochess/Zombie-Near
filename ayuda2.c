/*
** Programa para substituir aleatoriamente mosaicos 1 por 56
** (solo para usarse una vez por mapa)
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright 2011 Oscar Toledo Guti‚rrez
**
** Creaci¢n: 06-abr-2011.
*/

#include <stdio.h>
#include <string.h>

char lineas[1024][80];

/*
** Programa principal
*/
int main(void)
{
  int linea = 0;
  int max_linea = 0;
  char *ap;
  int c;

  srand(time(0));
  while (fgets(lineas[max_linea], 79, stdin))
    max_linea++;
  while (memcmp(lineas[linea], "mapa", 4) != 0)
    linea++;
  while (linea < max_linea) {
    ap = lineas[linea];
    while (*ap) {
      if (memcmp(ap, "01", 2) == 0) {
        c = rand();
        if ((c & 15) == 0) {
          if ((c & 16) == 0)
            memcpy(ap, "56", 2);
          else
            memcpy(ap, "57", 2);
        }
      }
      ap++;
    }
    linea++;
  }
  for (linea = 0; linea < max_linea; linea++)
    printf("%s", lineas[linea]);
}

