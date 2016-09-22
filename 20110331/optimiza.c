/*
** Optimiza color de gr ficas de Zombie Near
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright 2011 Oscar Toledo Guti‚rrez
**
** Creaci¢n: 27-mar-2011.
*/

#include <stdio.h>
#include <string.h>

unsigned char binario[4096];

unsigned char diccionario[4096];
int tam_dic;

int main(void);
void comprime(const char *, unsigned char *, int);

/*
** Programa principal
*/
int main(void)
{
  FILE *entrada;

  /*
  ** Este archivo se crea usando:
  **
  **   tniasm graforig.asm
  **   optimiza >tablas.asm
  **
  ** Se integra manualmente tablas.asm en graficas.asm
  */
  entrada = fopen("tniasm.out", "rb");
  fread(binario, 1, 4096, entrada);
  fclose(entrada);
  comprime("color_letras", binario + 0x01c0, 0x01c0);
  comprime("graf_color", binario + 0x09c0, 0x0640);
}

/*
** Comprime colores
*/
void comprime(const char *etiqueta, unsigned char *base, int tam)
{
  unsigned char *c;
  int d;
  int e;

  tam_dic = 0;
  e = 0;
  printf("\nindice_%s:\n", etiqueta);
  for (c = base; c < base + tam; c += 8) {
    for (d = 0; d < tam_dic; d += 8) {
      if (memcmp(c, &diccionario[d], 8) == 0)
        break;
    }
    if (d == tam_dic) {
      memcpy(&diccionario[tam_dic], c, 8);
      tam_dic += 8;
    }
    if ((e & 3) == 0)
      printf("        db ");
    else
      printf(",");
    printf("%d", d >> 3);
    if ((e & 3) == 3)
      printf("\n");
    e++;
  }
  printf("\n%s:\n", etiqueta);
  for (c = diccionario; c < diccionario + tam_dic; c += 8) {
    printf("        db $%02X,$%02X,$%02X,$%02X,$%02X,$%02X,$%02X,$%02X\n",
      c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7]);
  }
}

