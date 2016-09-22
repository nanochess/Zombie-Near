/*
** Comprobación de mensajes de Zombie Near
**
** por Oscar Toledo Gutiérrez
**
** (c) Copyright 2011 Oscar Toledo G.
**
** Creación: 20-ene-2011
*/

#include <stdio.h>

/*
** Programa principal
*/
int main(void)
{
  FILE *a;
  int b = 0;
  int c;
  
  /* Generar mediante TNIASM MENSAJES.ASM */
  a = fopen("tniasm.out", "rb");
  while (!feof(a)) {
    if (b < 86 && (b & 1) == 0) {  /* Mensajes con encabezado */
      getc(a);
      getc(a);
      getc(a);
    }
    b++;
    while ((c = getc(a) & 0xff) != 0xff) {
      if (c >= 0x01 && c <= 0x1a)
        c += 0x40;
      else if (c >= 0x20 && c <= 0x29)
        c += 0x10;
      else if (c == 0x2e)
        c = '!';
      else if (c == 0x2f)
        c = '?';
      else if (c == 0x36)
        c = 0xA5;
      else if (c == 0x37)
        c = 0xad;
      else if (c == 0x35)
        c = 0xa8;
      else if (c == 0x00)
        c = ' ';
      else if (c == 0xfe)
        c = '\n';
      else if (c == 0x30)
        c = '\'';
      else if (c == 0x34)
        c = '-';
      else
        c = '*';
      putchar(c);
    }
    putchar('\n');
    putchar('\n');
  }
  close(a);
}

