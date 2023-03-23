#!/cygdrive/c/Python39/python

import re, os, sys, math

if len(sys.argv) != 2:
    print("usage: _clang_fmt.py <infile>")
    sys.exit(1)

if not os.path.isfile(sys.argv[1]):
    print("error: <infile> not a file")
    sys.exit(2)

if not os.access(sys.argv[1], os.R_OK):
    print("error: <infile> not readable")
    sys.exit(3)

# pattern_comment1 = re.compile(r'/\*.*?\*/', re.DOTALL | re.MULTILINE)
# pattern_comment2 = re.compile(r'//.*$', re.M)

# pattern for comments are removed, instead use
# cpp -fpreprocessed -dD -E ${CFILE}
# for stripping comments in the real code with nested comments, such as
# /* // */
# /*  */ */

# pattern_trimright = re.compile(r'\s+$', re.M)    # correct
pattern_trimright = re.compile(r'^\s+$', re.M)
pattern_trimlines = re.compile(r'\n{2,}', re.M)
pattern_hex = re.compile(r'\b(0[xX][0-9a-f]+)\b')

try:
    content = open(sys.argv[1]).read()
except Exception as e:
    print("error: open file exception")
    sys.exit(4)


# content = pattern_comment1.sub("", content)
# content = pattern_comment2.sub("", content)

content = pattern_trimright.sub("", content)
content = pattern_trimlines.sub("\n", content)

cnt = 0
while True:
    cnt += 1
    replaced = False
    content_ = ""
    for line in content.splitlines():
        m = pattern_hex.search(line)
        if m:
            replaced = True
            p = m.group(1)
            # print(m.group(0))
            p_ = p.lstrip("0").lstrip("xX")
            width = 2*math.ceil(len(p_)/2)
            fmt = "0x%%0%iX" % (width)
            h = fmt % int(p_.upper(),16)
            line = line.replace(p, h)
        content_ += "%s\n" % line
    content = content_
    if replaced == False or cnt > 10:
        break

# open("%s_" % sys.argv[1], "w").write(content)
print(content)

