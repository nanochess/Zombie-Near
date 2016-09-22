/*
** Genera tabla de cambios de color
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright Oscar Toledo Guti‚rrez 2011
**
** Creaci¢n: 26-mar-2011.
*/

#include <stdio.h>

/*
** Programa principal
*/
int main(int argc, char *argv[])
{
  int c;
  int d;
  int e;
  int f;
  int g;
  int b;
  char *ap1;

  printf("tabla:\n");
  if (argc == 1) {
    for (c = 0; c < 256; c++) {
      if ((c & 0x0f) == 0)
        printf("        db ");
      e = 0;
      for (d = 0; d < 8; d++) {
        if ((c & (1 << d)) != 0)
          e |= 0x80 >> d;
      }
      printf("$%02X", e);
      if ((c & 0x0f) == 0x0f)
        printf("\n");
      else
        printf(",");
    }
    return 0;
  }
  for (c = 0; c < 256; c++) {
    if ((c & 0x0f) == 0)
      printf("        db ");
    f = 0;
    for (d = 0; d < 2; d++) {
      e = (d == 0) ? (c >> 4) : (c & 0x0f);
      ap1 = argv[1];
      while (*ap1) {
        g = toupper(*ap1) - '0';
        if (g > 9)
          g -= 7;
        b = toupper(ap1[1]) - '0';
        if (b > 9)
          b -= 7;
        if (e == g) {
          e = b;
          break;
        }
        ap1 += 2;
      }
      if (d == 0)
        f |= e << 4;
      else
        f |= e;
    }
    printf("$%02X", f);
    if ((c & 0x0f) == 0x0f)
      printf("\n");
    else
      printf(",");
  }
  return 0;
}

