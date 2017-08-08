#!/usr/bin/env python

import re

source_file = 'next_version.c'

version_string = 'const short BUILD = {};'
version_re = re.compile(version_string.format('(\d+)'))
data = []
with open(source_file) as f:
    for line in f:
        match = version_re.search(line)
        if match:
            version = int(match.group(1))
            data.append(version_string.format(version + 1) + '\n')
        else:
            data.append(line)

with open(source_file, 'w') as f:
    f.write(''.join(data))
