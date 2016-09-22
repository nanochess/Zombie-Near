/*
** Crujido, un compactador de niveles para Zombie Near
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright 2011 Oscar Toledo Guti‚rrez
**
** Creaci¢n: 26-mar-2011.
*/

#include <stdio.h>
#include <string.h>

FILE *entrada;
FILE *salida;

char linea[256];
int bytes;

void crujido(int);

/*
** Programa principal
*/
int main(void)
{
  int c;

  salida = fopen("mapas.asm", "w");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; Mapas compactados de Zombie Near\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; por Oscar Toledo Guti‚rrez\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; (c) Copyright 2011 Oscar Toledo Guti‚rrez\n");
  fprintf(salida, "        ;\n");
  fprintf(salida, "        ; Creaci¢n: 26-mar-2011. Generado autom ticamente.\n");
  fprintf(salida, "        ;\n");
  entrada = fopen("mapa1.asm", "r");
  while (fgets(linea, sizeof(linea) - 1, entrada)) {
    if (memcmp(linea + 4, "else", 4) == 0)
      break;
  }
  fprintf(salida, "mapa1:\n");
  for (c = 1; c < 103; c++)
   crujido(c);
  fclose(entrada);
  entrada = fopen("mapa2.asm", "r");
  fprintf(salida, "\nmapa2:\n");
  for (c = 1; c < 103; c++)
    crujido(c);
  fclose(entrada);
  entrada = fopen("mapa3.asm", "r");
  fprintf(salida, "\nmapa3:\n");
  for (c = 1; c < 103; c++)
    crujido(c);
  fclose(entrada);
  fclose(salida);
  printf("Reducidos a %d bytes\n", bytes);
}

#define escribe_bit(a) \
  if (bit == 0) \
    *ap3 = a << 7; \
  else \
    *ap3 |= (a & 1) << (7 - bit); \
  if (++bit == 8) { \
    bit = 0; \
    ap3++; \
  }

/*
** Compacta el nivel
*/
void crujido(int piso)
{
  char mapa[6 * 12];
  char buffer[6 * 12];
  char diccionario[256];
  int bit;
  char *ap1;
  char *ap2;
  char *ap3;
  int c;
  int d;
  int e;
  int f;
  char mapa_ref1[6 * 12] = {
    5,1,1,1,1,1,1,1,1,1,1,6,
    2,0,0,0,0,0,0,0,0,0,0,3,
    2,0,0,0,0,0,0,0,0,0,0,3,
    2,0,0,0,0,0,0,0,0,0,0,3,
    2,0,0,0,0,0,0,0,0,0,0,3,
    7,4,4,4,4,4,4,4,4,4,4,8,
  };
  char mapa_ref2[6 * 12] = {
    16,12,12,12,12,12,12,12,12,12,12,17,
    13,10,10,10,10,10,10,10,10,10,10,14,
    13,10,10,10,10,10,10,10,10,10,10,14,
    13,10,10,10,10,10,10,10,10,10,10,14,
    13,10,10,10,10,10,10,10,10,10,10,14,
    18,15,15,15,15,15,15,15,15,15,15,19,
  };
  int tam_dic;

  /*
  ** Lee un piso
  */
  ap2 = mapa;
  for (c = 0; c < 6; c++) {
    while (fgets(linea, sizeof(linea) - 1, entrada)) {
      if (memcmp(linea, "        db ", 11) == 0)
        break;
    }
    ap1 = linea + 11;
    for (d = 0; d < 12; d++) {
      *ap2++ = (ap1[0] - '0') * 10 + (ap1[1] - '0');
      ap1 += 3;
    }
  }

  /*
  ** Checa el tama¤o del diccionario de compactaci¢n
  */
  tam_dic = 0;
  if (mapa[0] == 5) {
    ap1 = mapa_ref1;
  } else {
    ap1 = mapa_ref2;
  }
  memset(diccionario, 0, sizeof(diccionario));
  for (ap2 = mapa; ap2 < mapa + 72; ap2++) {
    if (*ap1 != *ap2) {
      if (diccionario[*ap2] == 0)
        tam_dic++;
      diccionario[*ap2]++;
    }
    ap1++;
  }
  if (tam_dic > 15)
    printf("Diccionario muy grande para piso %d\n", piso);

  /*
  ** Ahora compacta de verdad
  **
  ** Los elementos que m s ocurren se ponen al principio, que es donde
  ** est n los c¢digos m s cortos (estilo Huffman)
  */
  ap3 = buffer;
  for (c = 0; c < tam_dic; c++) {
    d = -1;
    for (e = 0; e < 256; e++) {
      if (diccionario[e] > d) {
        d = diccionario[e];
        f = e;
      }
    }
    *ap3++ = (c == tam_dic - 1) ? f | 0x80 : f;
    diccionario[f] = 0;
  }
  ap3++;  /* Espacio para tama¤o datos compactados */
  bit = 0;
  if (mapa[0] == 5) {
    ap1 = mapa_ref1;
    escribe_bit(0);
  } else {
    ap1 = mapa_ref2;
    escribe_bit(1);
  }
  for (ap2 = mapa; ap2 < mapa + 72; ap2++) {
    if (*ap1 == *ap2) {
      escribe_bit(0);
    } else {
      for (c = 0; c < tam_dic; c++)
        if (*ap2 == (buffer[c] & 0x7f))
          break;
      if (tam_dic <= 4) {
        escribe_bit(1);
        escribe_bit(c >> 1);
        escribe_bit(c);
      } else if (tam_dic <= 8) {
        escribe_bit(1);
        escribe_bit(c >> 2);
        escribe_bit(c >> 1);
        escribe_bit(c);
      } else {
        if (c < 4) {
          escribe_bit(1);
          escribe_bit(0);
          escribe_bit(c >> 1);
          escribe_bit(c);
        } else if (c < 11) {
          c -= 4;
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(c >> 2);
          escribe_bit(c >> 1);
          escribe_bit(c);
        } else {
          c -= 11;
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(c >> 1);
          escribe_bit(c);
        }
      }
    }
    ap1++;
  }
  if (bit)
    ap3++;
  buffer[tam_dic] = ap3 - (buffer + tam_dic);
  if (ap3 - buffer > 72)
    printf("Salida m s grande que original para piso %d\n", piso);
  fprintf(salida, "        ; Piso: %d. Tam.dic = %d\n", piso, tam_dic);
  for (c = 0; c < ap3 - buffer; c++) {
    if ((c & 15) == 0) {
      fprintf(salida, "        db ");
    } else {
      fprintf(salida, ",");
    }
    fprintf(salida, "$%02X", buffer[c] & 255);
    bytes++;
    if (c == ap3 - buffer - 1 || (c & 15) == 15)
      fprintf(salida, "\n");
  }
}
