#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

SLIMECOIND=${SLIMECOIND:-$SRCDIR/slimecoind}
SLIMECOINCLI=${SLIMECOINCLI:-$SRCDIR/slimecoin-cli}
SLIMECOINTX=${SLIMECOINTX:-$SRCDIR/slimecoin-tx}
SLIMECOINQT=${SLIMECOINQT:-$SRCDIR/qt/slimecoin-qt}

[ ! -x $SLIMECOIND ] && echo "$SLIMECOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
RVNVER=($($SLIMECOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for slimecoind if --version-string is not set,
# but has different outcomes for slimecoin-qt and slimecoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$SLIMECOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $SLIMECOIND $SLIMECOINCLI $SLIMECOINTX $SLIMECOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${RVNVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${RVNVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
