#!/usr/bin/python
#
# Carlos Albornoz <caralbornozc@gmail.com>
#

RELATIVE = 1
BLOCK_SIZE = 2**20

import tarfile, os, sys

(xva_filename, ref, blocks, output) = tuple(sys.argv[1:])
blocks = int(blocks)
xva = tarfile.open(xva_filename)

def get_block(ref, n):
    try:
        b = xva.extractfile("%s/%08d" % (ref, n)).read()
        return b
    except KeyError:
        return None

fd = open(output, 'wb')
for n in range(0, blocks+1):
    if n % 123 == 0:
        print '\r', n,
        sys.stdout.flush()
    block = get_block(ref, n)
    if block is not None:
        fd.write(block)
    else:
        fd.seek(BLOCK_SIZE, RELATIVE)

print '\r', 'Done.          '
fd.close()
