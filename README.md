Mchmod.asm
==========

Haute École de Bruxelles - École Supérieure d'Informatique

Projet FS078 - Systèmes d'exploitation - 2013-2014

Simple implémentation de la commande chmod en assembleur x86.

Usage
-----
`make` dans le répertoire principal produit le rapport au format PostScript.
`make` dans le répertoire SOURCES produit un exécutable et lance une
démonstration.

Pour compiler l'exécutable sur une architecture 32 bits, modifiez la ligne
correspondante dans le Makefile.

`Mchmod` prend le mode au format octal en premier argument, puis une liste de
chemins de fichiers comme arguments suivants.

Dépendances
-----------
nasm, ld, latex, gv
