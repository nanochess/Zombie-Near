/*
** Convierte una imagen BMP a una pantalla de 16 colores
**
** por Oscar Toledo Guti‚rrez
**
** (c) Copyright 2009-2011 Oscar Toledo Guti‚rrez
**
** Creaci¢n: 06-jun-2009.
** Revisi¢n: 25-jun-2009. Optimiza el color para mejorar la descompactaci¢n,
**                        ahorra 25% de espacio.
** Revisi¢n: 10-ene-2011. Nuevo modo para gr fica 64x64.
** Revisi¢n: 11-ene-2011. Usa color transparente casi siempre.
** Revisi¢n: 16-ene-2011. Permite intercambiar colores.
** Revisi¢n: 08-feb-2011. Se cambian los valores de compactaci¢n para evitar
**                        incrementos/decrementos en descompactador.
** Revisi¢n: 15-feb-2011. Compila sin advertencias, evita optimizar color si no
**                        va a compactar. Se agrega info. de uso cambio color.
**                        Se agregan comentarios. Nuevo modo para convertir a
**                        imagen en gris.
** Revisi¢n: 26-mar-2011. Toma en cuenta el tam. de la imagen origen.
** Revisi¢n: 27-mar-2011. El buffer de compacta2 era muy corto.
** Revisi¢n: 28-mar-2011. Nuevo operador 0x80 para compactar patrones
**                        repetidos.
** Revisi¢n: 29-mar-2011. Mejora al determinar si operador 0x80 reduce bytes
**                        antes de aplicarlo. Mantiene el color negro a la
**                        derecha, esto optimiza la compactaci¢n de color.
** Revisi¢n: 11-abr-2011. Interlazado y cortina optimizan fondo negro usando
**                        byte 00.
** Revisi¢n: 13-abr-2011. Optimiza compactaci¢n de color de l¡neas de un solo
**                        color para interlazado y cortina, con nueva orden,
**                        y otra nueva orden para rellenar secuencias 00/ff.
** Revisi¢n: 14-abr-2011. Nueva orden para rellenar secuencias 00/ff con
**                        inc == 1.
** Revisi¢n: 09-may-2011. Mayor optimizaci¢n de color en secuencias con bytes
**                        de un solo tono.
** Revisi¢n: 11-may-2011. Genera archivos descompactados donde el color
**                        compacta mejor con plet5.
** Revisi¢n: 17-may-2011. Se desactiva detecci¢n de patr¢n, no se usa con
**                        retratos y se ahorra c¢digo en ZW.ASM.
*/

#include <stdio.h>
#include <stdlib.h>

unsigned char bitmap[6144];
unsigned char color[6144];
unsigned char medio[192][256];

int tam_x;              /* Tama¤o X de la imagen, debe ser m£ltiplo de 8 */
int tam_y;              /* Tama¤o Y de la imagen, debe ser m£ltiplo de 8 */
int inc;                /* Incremento */

/*
** Los colores MSX seg£n yo, son los que deben usarse en la imagen,
** en el Paint basta con definir el color RGB
*/ 
unsigned char colores[32 * 3] = {
  0x04, 0x05, 0x06,
  0x00, 0x00, 0x00,
  0x00, 0xdc, 0x00,
  0x78, 0xfc, 0x78,
  0xc8, 0x00, 0x00,
  0xf8, 0x80, 0x28,
  0x00, 0x00, 0xc8,
  0xe8, 0xfc, 0xa8,
  0x50, 0x54, 0xf8,
  0xa8, 0xa8, 0xf8,
  0x28, 0xd4, 0xf8,
  0xa8, 0xec, 0xf8,
  0x00, 0x74, 0x00,
  0xf8, 0x28, 0xd0,
  0xb8, 0xb8, 0xb8,
  0xf8, 0xfc, 0xf8,
  
  0x04, 0x05, 0x06,
  0x00, 0x00, 0x00,
  0x00, 0xdf, 0x00,
  0x7f, 0xff, 0x7f,
  0xcf, 0x00, 0x00,
  0xff, 0x80, 0x2f,
  0x00, 0x00, 0xcf,
  0xef, 0xff, 0xaf,
  0x50, 0x57, 0xff,
  0xaf, 0xa8, 0xff,
  0x2f, 0xd7, 0xff,
  0xaf, 0xef, 0xff,
  0x00, 0x77, 0x00,
  0xff, 0x2b, 0xd7,
  0xbf, 0xb8, 0xbf,
  0xff, 0xff, 0xff,
};

/*
** Prototipos
*/
int main(int, char *[]);
void compacta_cortina(char *, char *, FILE *);
void compacta3(char *, int, FILE *);
void compacta_interlazado(char *, char *, FILE *);
void compacta2(char *, FILE *, int);

/*
** Programa principal
*/
int main(int argc, char *argv[])
{
  FILE *entrada;
  FILE *salida;
  int c;
  int d;
  int e;
  unsigned char buffer[768];
  int uso[16];
  unsigned char mapa[16];
  int b;
  int g;
  int r;
  int offset;
  int max1;
  int color1;
  int max2;
  int color2;
  int max3;
  int color3;
  unsigned char *ap1;
  unsigned char *ap2;
  unsigned char *ap3;
  int color_dominante;

  /*
  ** Manual de uso, muy £til para acordarse de esos peque¤os detalles
  */
  if (argc < 3) {
    printf("Programa para crear imagenes compactadas. (c) 2011 Oscar Toledo G.");
    printf("\n");
    printf("Forma de uso:\n");
    printf("\n");
    printf("Crea imagen interlazada: (negro es transparente)\n");
    printf("  imagen archivo.bmp salida.dat\n");
    printf("\n");
    printf("Crea imagen en cortina:\n");
    printf("  imagen archivo.bmp salida.dat a\n");
    printf("\n");
    printf("Crea imagen con compactacion corrida:\n");
    printf("  imagen archivo.bmp salida.dat a b\n");
    printf("\n");
    printf("Crea imagen con compactacion corrida con color 5 cambiado a 6:\n");
    printf("  imagen archivo.bmp salida.dat a b 56\n");
    printf("\n");
    printf("Crea imagen con compactacion corrida con 5 a 6 y c a 4:\n");
    printf("  imagen archivo.bmp salida.dat a b 56c4\n");
    printf("\n");
    printf("Crea imagen interlazada: (triple tono, negro-gris-blanco)\n");
    printf("  imagen archivo.bmp salida.dat a b c d\n");
    printf("\n");
    exit(1);
  }
  if (argc == 4) {  /* Fondo transparente */
    colores[0] = 0;
    colores[1] = 0;
    colores[2] = 0;
    colores[3] = 4;
    colores[4] = 5;
    colores[5] = 6;
  }
  entrada = fopen(argv[1], "rb");
  if (entrada == NULL) {
    printf("Falla al leer entrada\n");
    exit(1);
  }
  salida = fopen(argv[2], "wb");
  if (salida == NULL) {
    fclose(entrada);
    printf("Falla al escribir salida\n");
    exit(1);
  }
  fread(buffer, 1, 54, entrada);
  tam_x = buffer[0x12] | (buffer[0x13] << 8);
  tam_y = buffer[0x16] | (buffer[0x17] << 8);

  /*
  ** Carga toda la imagen y va convirtiendo al formato VDP
  */
  for (c = 0; c < tam_y; c++) {
    fseek(entrada, 54 + ((tam_y - 1) - c) * tam_x * 3, SEEK_SET);
    fread(buffer, 1, tam_x * 3, entrada);
    for (d = 0; d < tam_x; d++) {
      b = buffer[d * 3];
      g = buffer[d * 3 + 1];
      r = buffer[d * 3 + 2];
      if (argc == 7) {
        r = (r * 30 + g * 59 + b * 11 + 49) / 100;
        if (r < 192)
          e = 1;
        else if (r < 240)
          e = 14;
        else
          e = 15;
      } else {

        /*
        ** Algunas variaciones de color admitidas por lapsus al dibujar
        */
        if (b == 0x30 && g == 0x30 && r == 0x30) {
          b = 0;
          g = 0;
          r = 0;
        }
        if (b == 0x78 && g == 0x7c && r == 0xf8) {
          colores[24] = 0x78;
          colores[25] = 0x7c;
          colores[26] = 0xf8;
          colores[18] = 0x50;
          colores[19] = 0x54;
          colores[20] = 0xf8;
        }
        if (b == 0x08 && g == 0x00 && r == 0x00) {
          b = 0;
          g = 0;
          r = 0;
        }
        if (b == 0x98 && g == 0x00 && r == 0x00) {
          b = 0xc8;
          g = 0;
          r = 0;
        }
        if (b == 0x00 && g == 0xff && r == 0x00) {
          b = 0;
          g = 0xdc;
          r = 0;
        }
        if (b == 0xff && g == 0xff && r == 0xff) {
          b = 0xf8;
          g = 0xfc;
          r = 0xf8;
        }
        if (b == 0x50 && g == 0xfc && r == 0x50) {
          b = 0x78;
          g = 0xfc;
          r = 0x78;
        }
        for (e = 0; e < 32; e++) {
          if (colores[e * 3] == b
           && colores[e * 3 + 1] == g
           && colores[e * 3 + 2] == r)
            break;
        }
        if (e == 32) {
          printf("Color no hallado %02x,%02x,%02x\n", b, g, r);
          e = 15;
        }
        if (e == 1 && argc != 5)
          e = 0;
        else if (argc == 6) {  /* ¨Traslado de color? */
          ap1 = argv[5];
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
        }
      }
      medio[c][d] = e & 0x0f;
    }
  }
  
#if 0  /* Comprime mejor sin esto */
  /*
  ** Determina el color dominante para mantenerlo a la derecha y optimizar
  ** compactación de color.
  */
  for (e = 0; e < 16; e++)
    uso[e] = 0;
  for (c = 0; c < tam_y; c++)
    for (d = 0; d < tam_x; d++)
      uso[medio[c][d]]++;
  d = -1;
  color_dominante = 0;
  for (c = 0; c < 16; c++) {
    if (uso[c] > d) {
      d = uso[c];
      color_dominante = c;
    }
  }
#endif

  for (c = 0; c < tam_y; c++) {

    /*
    ** Calcula los dos colores m s usados por cada 8 pixeles
    **
    ** El dibujante tiene la responsabilidad de optimizar la imagen origen
    */
    for (d = 0; d < tam_x; d += 8) {
      offset = c / 8 * tam_x + (c & 7) + d;
      for (e = 0; e < 16; e++)
        uso[e] = 0;
      for (e = 0; e < 8; e++) 
        uso[medio[c][d + e]]++;
      do {
        max1 = -1;
        color1 = -1;
        max2 = -1;
        color2 = -1;
        max3 = -1;
        color3 = -1;
        for (e = 0; e < 16; e++) {
          if (uso[e] > max1) {
            max1 = uso[e];
            color1 = e;
          }
        }
        for (e = 0; e < 16; e++) {
         if (uso[e] > max2 && e != color1) {
             max2 = uso[e];
            color2 = e;
          }
        }
        for (e = 0; e < 16; e++) {
          if (uso[e] > max3 && e != color1 && e != color2) {
            max3 = uso[e];
            color3 = e;
          }
        }
        if (max3 == 0)
          break;
        uso[color3] = 0;
        mapa[color3] = 0;        
      } while (1) ;
      if (max1 > 0)
        mapa[color1] = 1;
      if (max2 > 0)
        mapa[color2] = 0;
      color1 &= 0x0f;
      color2 &= 0x0f;
      color[offset] = color1 << 4 | color2;
      r = 0;
      for (e = 0; e < 8; e++) 
        r = (r << 1) | mapa[medio[c][d + e]];
      bitmap[offset] = r;
      
      /*
      ** Mantiene el negro a la derecha para optimizar color
      */
      if (color1 < 2 && color2 >= 2) {
        bitmap[offset] = ~r;
        color[offset] = color2 << 4 | color1;
      }
      offset += 8;
    }
  }

  /*
  ** Optimiza el color para mejorar la compactaci¢n
  **
  ** Observe que se hace de 8 en 8 bytes, puesto que la imagen se compacta
  ** por l¡neas de pixeles, y el pr¢ximo byte de cada l¡nea se halla cada
  ** 8 bytes.
  **
  ** Si se requiriera compactaci¢n corrida (p.ej. para descompactar en un
  ** buffer) entonces si se debe hacer por bytes seguidos.
  */
  if (argc != 5 && argc != 6 && argc != 8) {
    inc = 8;
  } else {
    inc = 1;
  }
  for (c = 0; c < inc; c++) {
    for (d = 0; d < tam_y / 8; d++) {
    
      /*
      ** Optimiza secuencias de pixeles de un solo color para que usen el
      ** mismo c¢digo de color
      */
      ap1 = color + c + d * tam_x;
      ap2 = bitmap + c + d * tam_x;
      e = 0;
      do {
        b = *ap1;
        g = *ap2;
        ap1 += inc;
        ap2 += inc;
        for (r = 1; e + r < tam_x / inc; r++) {
          if (*ap1 != b || *ap2 != g)
            break;
          ap1 += inc;
          ap2 += inc;
        }
        e += r;
        if (e < tam_x / inc) {
          if (g == 0x00) {
            if ((b & 0x0f) == (*ap1 & 0x0f)) {
              b = *ap1;
              do {
                ap1[-r * inc] = b;
                ap2[-r * inc] = g;
              } while (--r) ;
            } else if ((b & 0x0f) == (*ap1 & 0xf0)) {
              b = *ap1;
              g = 0xff;
              do {
                ap1[-r * inc] = b;
                ap2[-r * inc] = g;
              } while (--r) ;
            }
          } else if (g == 0xff) {
            if ((b & 0xf0) == (*ap1 & 0xf0)) {
              b = *ap1;
              do {
                ap1[-r * inc] = b;
                ap2[-r * inc] = g;
              } while (--r) ;
            } else if ((b >> 4) == (*ap1 & 0x0f)) {
              b = *ap1;
              g = 0x00;
              do {
                ap1[-r * inc] = b;
                ap2[-r * inc] = g;
              } while (--r) ;
            }
          }
        }
      } while (e < tam_x / inc) ;
      ap1 = color + c + d * tam_x;
      ap2 = bitmap + c + d * tam_x;
      b = *ap1;
      g = *ap2;
      ap1 += inc;
      ap2 += inc;
      for (e = 1; e < tam_x / inc; e++) {
        if ((*ap1 >> 4) == (b >> 4) && *ap2 == 0xff) {
          *ap1 = b;
        }
        if ((*ap1 & 0x0f) == (b & 0x0f) && *ap2 == 0x00) {
          *ap1 = b;
        } 
        if (((*ap1 >> 4 | *ap1 << 4) & 0xff) == b) {
          *ap1 = b;
          *ap2 = ~*ap2;
        }
        if ((*ap1 >> 4) == (b & 0x0f) && *ap2 == 0xff) {
          *ap1 = b;
          *ap2 = 0x00;
        }
        if ((*ap1 & 0x0f) == (b >> 4) && *ap2 == 0x00) {
          *ap1 = b;
          *ap2 = 0xff;
        }
        if ((~*ap2 & 0xff) == g && *ap1 != b) {
          *ap1 = *ap1 >> 4 | *ap1 << 4;
          *ap2 = g;
        }
        b = *ap1;
        g = *ap2;
        ap1 += inc;
        ap2 += inc;
      }
    }
  }
#if 1
  if (argc == 8) {  /* Optimiza color para patrones, útil con plet5 */
    for (d = 0; d < tam_y / 8; d++) {
      ap1 = color + d * tam_x;
      ap2 = bitmap + d * tam_x;
      e = 0;
      do {
        r = 0;
        g = 0;
        for (c = e; c < e + 8; c++) {
          if (ap1[c] == ap1[c + 8]) {
            r++;
            continue;
          }
          if ((ap1[c] & 0x0f) == (ap1[c + 8] & 0x0f)
           && ap2[c + 8] == 0x00)
            g++;
          else if ((ap1[c] & 0xf0) == (ap1[c + 8] & 0xf0)
                 && ap2[c + 8] == 0xff)
            g++;
          else if (ap1[c] == ((ap1[c + 8] >> 4 | ap1[c + 8] << 4) & 0xff))
            g++;
        }
        if (1/*r + g == 8*/) {
          for (c = e; c < e + 8; c++) {
            if (ap1[c] == ap1[c + 8])
              continue;
            if ((ap1[c] & 0x0f) == (ap1[c + 8] & 0x0f)
             && ap2[c + 8] == 0x00)
              ap1[c + 8] = ap1[c];
            else if ((ap1[c] & 0xf0) == (ap1[c + 8] & 0xf0)
                   && ap2[c + 8] == 0xff)
              ap1[c + 8] = ap1[c];
            else if (ap1[c] == ((ap1[c + 8] >> 4 | ap1[c + 8] << 4) & 0xff)) {
              ap2[c + 8] = ~ap2[c + 8];
              ap1[c + 8] = ap1[c];
            }
          }
        }
        e += 8;
      } while (e + 8 < tam_x) ;
    }
  }
#endif
  if (argc == 8) {
    fwrite(bitmap, 1, tam_x * tam_y / 8, salida);
    fwrite(color, 1, tam_x * tam_y / 8, salida);
  } else if (argc == 5 || argc == 6) {
    for (c = 0; c < tam_y; c += 8) {
      compacta2(bitmap + (c >> 3) * tam_x, salida, 1);
    }
    for (c = 0; c < tam_y; c += 8) {
      compacta2(color + (c >> 3) * tam_x, salida, 1);
    }
  } else if (argc == 4) {
    compacta_cortina(bitmap, color, salida);
  } else {
    compacta_interlazado(bitmap, color, salida);
  }
  fclose(salida);
  fclose(entrada);
}

/*
** Compacta un bitmap en forma de cortina que se abre del centro hacia afuera
*/
void compacta_cortina(char *ap1, char *ap2, FILE *salida)
{
  int c;
  int d;

  c = tam_y / 2 - 1;
  d = tam_y / 2;
  while (d < tam_y) {
    if (c >= 0) {
      compacta3(ap1 + (c & 7) + ((c >> 3) * tam_x), 1, salida);
      compacta3(ap2 + (c & 7) + ((c >> 3) * tam_x), 0, salida);
    }
    compacta3(ap1 + (d & 7) + ((d >> 3) * tam_x), 1, salida);
    compacta3(ap2 + (d & 7) + ((d >> 3) * tam_x), 0, salida);
    c--;
    d++;
  }
}

/*
** Verifica si puede optimizar la compactaci¢n
*/
void compacta3(char *ap1, int bitmap, FILE *salida)
{
  int c;
  int d;
  char *ap;
  int valor;

  ap = ap1;
  d = *ap;
  ap += 8;
  for (c = 1; c < 32; c++) {
    if (*ap != d)
      break;
    ap += 8;
  }
  if (bitmap) {
    valor = 0xff;
  } else {
    if (d == 0x01)
      valor = 0x01;
    else if ((d & 0x0f) == 0x00)
      valor = d & 0xff;
    else
      valor = -1;
  }
  if (c < 32 || (d & 0xff) != valor) {
    compacta2(ap1, salida, 8);
    return;
  }
  if (bitmap || valor == 0x01)
    fputc(0x00, salida);  
  else
    fputc(0x70 | (d >> 4) & 0x0f, salida);
}

/*
** Compacta un bitmap y su color de forma interlazada
*/
void compacta_interlazado(char *ap1, char *ap2, FILE *salida)
{
  int c;
  int d;

  for (c = 0; c < 8; c++) {
    for (d = 0; d < tam_y / 8; d++) {
      compacta3(ap1 + c + d * tam_x, 1, salida);
      compacta3(ap2 + c + d * tam_x, 0, salida);
    }
  }
}

/*
** Compactaci¢n tipo RLE (Run-Length-Encoded)
**
** La tasa m xima de ineficiencia es de un byte extra por cada 32 bytes.
** La tasa m xima de compresi¢n es 2 bytes por cada 32 bytes.
**
** Este algoritmo se basa en detectar tiras de bytes iguales, por lo que se
** beneficia mucho de la optimizaci¢n de colores similares que se realiza
** antes de entrar aqu¡.
**
** La implementaci¢n del descompactador es r pida y sencilla, suficientemente
** veloz para realizarse dentro de la rutina de interrupci¢n.
**
** Otros algoritmos pudieran ser m s efectivos pero tambi‚n m s lentos para
** descompactar. Siempre hay un equilibrio compresi¢n/velocidad/dificultad.
*/
void compacta2(char *ap1, FILE *salida, int inc)
{
  char buffer[256];
  char *ap2;
  char *ap3;
  char *ap4 = buffer;
  int c;
  int d;
  int inicio_tira;
  int largo_tira;
  int cuenta;
  int por_comparar;
  int maximo;
  char *ap5;
  char *ap6;
  int estimado;

  ap2 = ap1 + tam_x;
  while (ap1 < ap2) {  /* Mientras haya datos de entrada */
#if 0  /* Busca repetici¢n de patr¢n, solo eficaz con inc == 1 porque */
       /* entonces localiza las repeticiones cada 8 bytes a la par con */
       /* el ordenamiento de video del VDP */
    if (inc == 1 && ap1 + 3 * inc < ap2) {
      for (maximo = 8; maximo >= 2; maximo--) {
        cuenta = 0;
        while (cuenta < 14) {
          if (ap1 + (cuenta + 2) * maximo * inc > ap2)
            break;
          ap5 = ap1 + (cuenta * maximo) * inc;
          ap6 = ap1 + (cuenta + 1) * maximo * inc;
          d = maximo;
          while (d && *ap5 == *ap6) {
            ap5 += inc;
            ap6 += inc;
            d--;
          }
          if (d != 0)
            break;
          cuenta++;
        }
        if (cuenta > 0) {

          /*
          ** Estima cuanto sería con el algoritmo normal
          */
          estimado = 0;
          ap6 = ap1;
          ap5 = ap1 + (cuenta + 1) * maximo * inc;
          while (ap6 < ap5) {
            c = *ap6;
            ap6 += inc;
            if (ap6 == ap5) {
              estimado += 2;
              break;
            }
            if (c == *ap6) {   /* ¨Byte repetido? */
              d = 0x00fe;  /* 08-feb-2011, antes 0x0100 */
              while (ap6 < ap5 && *ap6 == c && d != 0x81) {  /* Busca m s */
                d--;
                ap6 += inc;
              }
              estimado += 2;
              continue;
            }
            ap3 = ap6 - inc;
            d = 1;             /* 08-feb-2011, antes 0 */
            while (ap6 < ap5
                && d != 127
                && (ap6 + inc == ap5
                 || *ap6 != *(ap6 + inc)
                 || ap6 + inc * 2 < ap5 && *ap6 != *(ap6 + inc * 2))) {
              d++;
              ap6 += inc;
            }
            estimado += 1 + (ap6 - ap3) / inc;
          }
          if (maximo + 2 < estimado)
            break;
        }
      }
      if (maximo >= 2) {
        *ap4++ = 0x80;
        *ap4++ = (cuenta + 1) << 4 | maximo;
        d = maximo;
        do {
          *ap4++ = *ap1;
          ap1 += inc;
        } while (--d) ;
        ap1 += cuenta * maximo * inc;
        continue;
      }
    }
#endif
#if 0  /* Busca tiras repetidas usando buffer, no es efectivo */
    inicio_tira = 0;
    largo_tira = -1;
    if (inc == 1) {
      for (d = 0; d < ap4 - buffer; d++) {
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
      *ap4++ = 0x80;
      *ap4 = inicio_tira - (ap4 - buffer);
      ap4++;
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
      while (ap1 < ap2 && *ap1 == c && d != 0x81) {  /* Busca m s */
        d--;
        ap1 += inc;
      }
      if (inc == 8 && c == 0) {
        *ap4++ = 0x80 + (0xfe - d) * 2;  /* Repetición cero */
      } else if (inc == 8 && (c & 0xff) == 0xff) {
        *ap4++ = 0x81 + (0xfe - d) * 2;  /* Repetición unos */
      } else if (inc == 1 && (c == 0 || (c & 0xff) == 0xff)) {
        d = 0xff - d;
        while (d) {
          if (d > 32)
            maximo = 32;
          else
            maximo = d;
          *ap4++ = ((c == 0) ? 0x40 : 0x41) + (maximo - 1) * 2;
          d -= maximo;
        }
      } else {
        *ap4++ = d;      /* Repetici¢n */
        *ap4++ = c;      /* Byte */
      }
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
        && d != 63
        && (ap1 + inc == ap2
         || *ap1 != *(ap1 + inc)
         || ap1 + inc * 2 < ap2 && *ap1 != *(ap1 + inc * 2))) {
      d++;
      ap1 += inc;
    }
    if (d == 1) {
      if (inc == 8 && *ap3 == 0) {
        *ap4++ = 0x80;  /* Repetición cero */
        d = 0;
      } else if (inc == 8 && (*ap3 & 0xff) == 0xff) {
        *ap4++ = 0x81;  /* Repetición unos */
        d = 0;
      } else if (inc == 1 && (*ap3 == 0 || (*ap3 & 0xff) == 0xff)) {
        *ap4++ = ((*ap3 == 0) ? 0x40 : 0x41);
        d = 0;
      }
    }
    if (d != 0) {
      *ap4++ = d;        /* Bytes por copiar */
      while (ap3 < ap1) {
        *ap4++ = *ap3;   /* Copia bytes */
        ap3 += inc;
      }
    }
  }
  fwrite(buffer, 1, ap4 - buffer, salida);
}
