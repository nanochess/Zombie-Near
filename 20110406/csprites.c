/*
** Compacta los sprites de Zombie Near
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright 2011 Oscar Toledo Guti‚rrez
**
** Creaci¢n: 31-mar-2011. Basado en imagen.c
*/

#include <stdio.h>
#include <stdlib.h>

unsigned char datos[8192];
unsigned char buffer[8192];
unsigned char espejo[256];

/*
** Prototipos
*/
int main(int, char *[]);
void compacta2(unsigned char *, int, FILE *, int);

/*
** Programa principal
*/
int main(int argc, char *argv[])
{
  FILE *entrada;
  FILE *salida;
  int tam;
  
  for (tam = 0; tam < 256; tam++) {
    espejo[tam] = (tam & 1) << 7
                | (tam & 2) << 5
                | (tam & 4) << 3
                | (tam & 8) << 1
                | (tam & 16) >> 1
                | (tam & 32) >> 3
                | (tam & 64) >> 5
                | (tam & 128) >> 7;
  }

  /*
  ** Entrada generada mediante:
  **   tniasm sprites.asm
  */
  entrada = fopen("tniasm.out", "rb"),
  tam = fread(datos, 1, sizeof(datos), entrada);
  fclose(entrada);
  printf("Entrada de %d bytes\n", tam);
  salida = fopen("sprites2.asm", "wb");
  compacta2(datos, tam, salida, 1);
  fclose(salida);
}

/*
** Compactaci¢n tipo RLE (Run-Length-Encoded)
**
** La tasa m xima de ineficiencia es de un byte extra por cada 32 bytes.
** La tasa m xima de compresi¢n es 2 bytes por cada 32 bytes.
**
** Otros algoritmos pudieran ser m s efectivos pero tambi‚n m s lentos para
** descompactar. Siempre hay un equilibrio compresi¢n/velocidad/dificultad.
*/
void compacta2(unsigned char *ap1, int tam, FILE *salida, int inc)
{
  unsigned char *base;
  unsigned char *ap2;
  unsigned char *ap3;
  unsigned char *ap4 = buffer;
  int c;
  int d;
  int inicio_tira;
  int largo_tira;
  int cuenta;
  int por_comparar;
  int maximo;
  unsigned char *ap5;
  unsigned char *ap6;
  int estimado;

  base = ap1;
  ap2 = ap1 + tam;
  while (ap1 < ap2) {  /* Mientras haya datos de entrada */
#if 1  /* Busca espejo exacto */
    if (ap2 - ap1 >= 16) {  /* Optimizado para sprites de 16x16 */
      for (c = 0; c < ap1 - base; c++) {
        for (d = 0; d < 16; d++)
          if (ap1[d] != espejo[base[c + d]])
            break;
        if (d == 16)
          break;
      }
      if (c < ap1 - base) {
        c -= ap1 - base;
        ap1 += 16;
        *ap4++ = 0x81;
        *ap4++ = c;
        *ap4++ = c >> 8;
        continue;
      }
    }
#endif
#if 1  /* Busca tiras repetidas usando buffer, bastante efectivo */
    inicio_tira = 0;
    largo_tira = -1;
    if (inc == 1) {
      d = ap4 - buffer - 256;
      if (d < 0)
        d = 0;
      for (; d < ap4 - buffer; d++) {
        por_comparar = (ap2 - ap1) / inc;
        maximo = ap4 - buffer - d;
        if (por_comparar > maximo)
          por_comparar = maximo;
        for (c = 0; c < por_comparar; c++) {
          if (buffer[d + c] != ap1[c * inc])
            break;
        }
        if (c > largo_tira) {
          largo_tira = c;
          inicio_tira = d;
        }
      }
    }
    if (largo_tira > 3) {
      c = inicio_tira - (ap4 - buffer);
      *ap4++ = 0x80;
      *ap4++ = c;
      *ap4++ = largo_tira;
      ap1 += largo_tira * inc;
      continue;
    }
#endif
    c = *ap1;
    ap1 += inc;
    if (ap1 == ap2) {  /* ¨Fin de compactaci¢n? entonces sobra un byte */
      *ap4++ = 1;      /* 08-feb-2011, antes 0 */
      *ap4++ = c;
      break;
    }
    if (c == *ap1) {   /* ¨Byte repetido? */
      d = 0x00fe;  /* 08-feb-2011, antes 0x0100 */
      while (ap1 < ap2 && *ap1 == c && d != 0x82) {  /* Busca m s */
        d--;
        ap1 += inc;
      }
      *ap4++ = d;      /* Repetici¢n */
      *ap4++ = c;      /* Byte */
      continue;
    }

    /*
    ** Bytes diferentes, copia directamente, tolera hasta tres bytes
    ** iguales antes de salir de copia, menos es ineficiente,
    ** por ejemplo:
    **
    **    Caso cl sico de dos bytes
    **      aa bb cc cc bb aa bb aa
    **
    **    Sin optimizaci¢n (10 bytes de salida)
    **      02 aa bb fd cc 04 bb aa bb aa
    **
    **    Con optimizaci¢n (9 bytes de salida)
    **      08 aa bb cc cc bb aa bb aa
    **
    **
    **    Caso cl sico de tres bytes
    **      aa bb cc cc cc bb aa bb aa
    **
    **    Sin optimizaci¢n (10 bytes de salida)
    **      02 aa bb fc cc 04 bb aa bb aa
    **
    **    Con optimizaci¢n (10 bytes de salida)
    **      09 aa bb cc cc cc bb aa bb aa
    **
    **    Observe que se ocupa lo mismo, pero es mejor con la optimizaci¢n
    **    de lo contrario hay una tasa de recarga (overhead) porque el
    **    descompactador tiene que procesar dos ¢rdenes m s.
    **
    **
    **    Caso cl sico de cuatro bytes
    **      aa bb cc cc cc cc bb aa bb aa
    **
    **    Sale al detectar cuarto byte (10 bytes de salida)
    **      02 aa bb fb cc 04 bb aa bb aa
    **
    **    Ya no conviene dejarlo en copia (ser¡an 11 bytes)
    */
    ap3 = ap1 - inc;
    d = 1;             /* 08-feb-2011, antes 0 */
    while (ap1 < ap2
        && d != 127
        && (ap1 + inc == ap2
         || *ap1 != *(ap1 + inc)
         || ap1 + inc * 2 < ap2 && *ap1 != *(ap1 + inc * 2))) {
      d++;
      ap1 += inc;
    }
    *ap4++ = d;        /* Bytes por copiar */
    while (ap3 < ap1) {
      *ap4++ = *ap3;   /* Copia bytes */
      ap3 += inc;
    }
  }
  *ap4++ = 0;  /* Marcador de final */
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; Sprites compactados para Zombie Near\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; por Oscar Toledo Guti‚rrez\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; Creaci¢n: 31-mar-2011.\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "\n");
  fprintf(salida, "sprites_heroes:     equ $c000\n");
  fprintf(salida, "figuras_sprites:    equ $c4c0\n");
  fprintf(salida, "sprites_jefes:      equ $cbc0\n");
  fprintf(salida, "\n");
  fprintf(salida, "sprites_compactados:\n");
  for (c = 0; c < ap4 - buffer; c++) {
    if ((c & 15) == 0) {
      fprintf(salida, "        db ");
    } else {
      fprintf(salida, ",");
    }
    fprintf(salida, "$%02X", buffer[c] & 255);
    if (c == ap4 - buffer - 1 || (c & 15) == 15)
      fprintf(salida, "\n");
  }
  printf("Reducido a %d bytes\n", ap4 - buffer);
}
