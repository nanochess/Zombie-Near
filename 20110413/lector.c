/*
** Comprobación de mensajes de Zombie Near
**
** por Oscar Toledo Gutiérrez
**
** (c) Copyright 2011 Oscar Toledo G.
**
** Creación: 20-ene-2011.
** Revisión: 01-abr-2011. Actualizado para los mensajes extra del mapa 4.
** Revisión: 02-abr-2011. Organiza en dos columnas, verifica que el texto cabe
**                        en el tamaño asignado e indica quien lo dice.
*/

#include <stdio.h>
#include <string.h>

/*
** Programa principal
*/
int main(void)
{
  FILE *a;
  int b = 0;
  int c;
  int d;
  int e;
  int ancho;
  int alterna;
  char buffer[321];  /* Hasta 4 líneas de 80 caracteres */
  int lin;
  int col;
  int max_lin;
  char *ap;
  
  /* Generar mediante TNIASM MENSAJES.ASM */
  alterna = 0;
  lin = 0;
  memset(buffer, ' ', 320);
  buffer[78] = '\n';
  buffer[79] = '\0';
  buffer[158] = '\n';
  buffer[159] = '\0';
  buffer[238] = '\n';
  buffer[239] = '\0';
  buffer[318] = '\n';
  buffer[319] = '\0';
  a = fopen("tniasm.out", "rb");
  printf("Messages and dialogs for Zombie Near\n");
  printf("(c) Copyright 2011 Oscar Toledo G.\n\n");
  printf("\n");
  printf("    English                        Spanish\n");
  printf("\n");
  while (!feof(a)) {
    if (b < 118) {
      if ((b & 1) == 0) {  /* Mensajes con encabezado */
        getc(a);
        c = getc(a);
        if ((c & 0xf0) == 0x10) {
          if (alterna == 0)
            printf("Delta 1\n");
          else
            printf("Delta 2\n");
          alterna = !alterna;
        }
        if ((c & 0xf0) == 0x20)
          printf("Telephone girl\n");
        if ((c & 0xf0) == 0x30)
          printf("Researcher\n");
        if ((c & 0xf0) == 0x40)
          printf("Boss\n");
        if ((c & 0xf0) == 0x50)
          printf("Evil boss\n");
        ancho = c & 0x0f;
        e = 0;
      }
      if (b & 1)
        col = 36;
      else {
        col = 5;
        max_lin = 0;
      }
    } else {  /* Límite de 14 caracteres para presentación */
      if (b == 118)
        printf("Story\n");
      ancho = -1;
      e = 0;
      if (b & 1)
        col = 31;
      else {
        col = 0;
        max_lin = 0;
      }
    }
    b++;
    while (1) {
      c = getc(a);
      if (c == EOF)
        break;
      c &= 0xff;
      d = c;
      c &= 0x3f;
      if (e == 0 && (col == 5 || col == 36)) {
        buffer[lin * 80 + col - 5] = ' ';
        buffer[lin * 80 + col - 4] = ' ';
        buffer[lin * 80 + col - 3] = ' ';
        buffer[lin * 80 + col - 2] = ' ';
        buffer[lin * 80 + col - 1] = '|';
      }
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
      else if (c == 0x30)
        c = '\'';
      else if (c == 0x34)
        c = '-';
      else if (c == 0x3e)
        c = '#';
      else if (c == 0x3f)
        c = '$';
      else
        c = '*';
      buffer[lin * 80 + col + e] = c;
      e++;
      if ((d & 0xc0) != 0 && ancho >= 0) {
        if (e > ancho) {
          buffer[lin * 80 + col + e++] = '|';
          buffer[lin * 80 + col + e++] = 'e';
          buffer[lin * 80 + col + e++] = 'r';
          buffer[lin * 80 + col + e++] = 'r';
          buffer[lin * 80 + col + e++] = 'o';
          buffer[lin * 80 + col + e++] = 'r';
          buffer[lin * 80 + col + e++] = '|';
        }
        while (e < ancho) {
          buffer[lin * 80 + col + e] = ' ';
          e++;
        }
        buffer[lin * 80 + col + e++] = '|';
      }
      if (d & 0x40) {
        lin++;
        e = 0;
      }
      if (d & 0x80) {
        lin++;
        e = 0;
        if (lin > max_lin)
          max_lin = lin;
        if (col > 30) {
          if (max_lin >= 1) {
            c = 77;
            while (buffer[c] == ' ')
              c--;
            buffer[c + 1] = '\n';
            buffer[c + 2] = '\0';
            printf(buffer);
          }
          if (max_lin >= 2) {
            c = 157;
            while (buffer[c] == ' ')
              c--;
            buffer[c + 1] = '\n';
            buffer[c + 2] = '\0';
            printf(buffer + 80);
          }
          if (max_lin >= 3) {
            c = 237;
            while (buffer[c] == ' ')
              c--;
            buffer[c + 1] = '\n';
            buffer[c + 2] = '\0';
            printf(buffer + 160);
          }
          if (max_lin >= 4) {
            c = 317;
            while (buffer[c] == ' ')
              c--;
            buffer[c + 1] = '\n';
            buffer[c + 2] = '\0';
            printf(buffer + 240);
          }
          memset(buffer, ' ', 320);
          buffer[78] = '\n';
          buffer[79] = '\0';
          buffer[158] = '\n';
          buffer[159] = '\0';
          buffer[238] = '\n';
          buffer[239] = '\0';
          buffer[318] = '\n';
          buffer[319] = '\0';
        }
        lin = 0;
        break;
      }
    }
    putchar('\n');
  }
  close(a);
}
