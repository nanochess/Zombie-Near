/*
** Crujido, un compactador de niveles para Zombie Near
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright 2011 Oscar Toledo Guti‚rrez
**
** Creaci¢n: 26-mar-2011.
** Revisi¢n: 31-mar-2011. Elimina bytes cero finales, el descompactador se
**                        entera siguiendo el tama¤o de datos compactados.
**                        Se a¤ade el mapa 4.
** Revisi¢n: 05-abr-2011. Cuenta zombies, cient¡ficos y vidas por mapa.
** Revisi¢n: 12-may-2011. Se optimiza el diccionario de 8 s¡mbolos.
** Revisi¢n: 17-may-2011. Se optimiza otra vez el diccionario de 8 s¡mbolos y
**                        se elimina el de 4 s¡mbolos.
*/

#include <stdio.h>
#include <string.h>

FILE *entrada;
FILE *salida;

char linea[256];
int bytes;

int zombies;
int cientificos;
int vidas;

int td_usado[16];
int simbolo[32];

void crujido(int);

/*
** Programa principal
*/
int main(void)
{
  int c;
  int base;

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
  zombies = 0;
  cientificos = 0;
  vidas = 0;
  entrada = fopen("mapa1.asm", "r");
  while (fgets(linea, sizeof(linea) - 1, entrada)) {
    if (memcmp(linea + 4, "else", 4) == 0)
      break;
  }
  base = bytes;
  fprintf(salida, "mapa1:\n");
  for (c = 1; c < 103; c++)
   crujido(c);
  fclose(entrada);
  printf("Zombies: %d, cient¡ficos: %d, vidas: %d\n",
    zombies, cientificos, vidas);
  printf("Mapa 1 reducido a %d bytes\n", bytes - base);
  zombies = 0;
  cientificos = 0;
  vidas = 0;
  entrada = fopen("mapa2.asm", "r");
  base = bytes;
  fprintf(salida, "\nmapa2:\n");
  for (c = 1; c < 103; c++)
    crujido(c);
  fclose(entrada);
  printf("Zombies: %d, cient¡ficos: %d, vidas: %d\n",
    zombies, cientificos, vidas);
  printf("Mapa 2 reducido a %d bytes\n", bytes - base);
  zombies = 0;
  cientificos = 0;
  vidas = 0;
  entrada = fopen("mapa3.asm", "r");
  base = bytes;
  fprintf(salida, "\nmapa3:\n");
  for (c = 1; c < 103; c++)
    crujido(c);
  fclose(entrada);
  printf("Zombies: %d, cient¡ficos: %d, vidas: %d\n",
    zombies, cientificos, vidas);
  printf("Mapa 3 reducido a %d bytes\n", bytes - base);
  fclose(salida);
  printf("El archivo integrado ocupa %d bytes\n", bytes);
  for (c = 0; c < 16; c++) {
    if (!td_usado[c])
      continue;
    printf("Tam.dic %d usado %d veces.\n",
      c, td_usado[c]);
  }
  for (c = 0; c < 32; c++) {
    if (!simbolo[c])
      continue;
    printf("Simbolo %d usado %d veces.\n",
      c, simbolo[c]);
  }
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
    if (*ap2 == 69 || *ap2 == 70 || *ap2 == 75
     || *ap2 == 76 || *ap2 == 77
     || (*ap2 >= 80 && *ap2 <= 83)
     || (*ap2 >= 90 && *ap2 <= 95))
      zombies++;
    else if (*ap2 >= 85 && *ap2 <= 86)
      cientificos++;
    else if (*ap2 == 78)
      vidas++;
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
      if (tam_dic <= 8) {
        simbolo[c + 4]++;
        if (c < 2) {
          escribe_bit(1);
          escribe_bit(0);
          escribe_bit(c);
        } else if (c < 5) {
          c -= 2;
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(c >> 1);
          escribe_bit(c);
        } else if (c < 6) {
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(0);
        } else {
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(1);
          escribe_bit(c);
        }
      } else {
        simbolo[c + 12]++;
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
  while (ap3[-1] == 0x00)  /* Elimina bytes cero finales */
    ap3--;
  buffer[tam_dic] = ap3 - (buffer + tam_dic);
  if (ap3 - buffer > 72)
    printf("Salida m s grande que original para piso %d\n", piso);
  fprintf(salida, "        ; Piso: %d. Tam.dic = %d\n", piso, tam_dic);
  td_usado[tam_dic]++;
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
