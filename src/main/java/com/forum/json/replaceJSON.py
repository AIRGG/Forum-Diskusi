dari = "package com.CRUDAJAX.json;"
jadinya = "package com.forum.json;"

import os

for root, dirs, files in os.walk(os.getcwd()):
  for a in files:
   if (not a.endswith(".java")):
    continue
   filenya = os.path.join(root, a)
   with open(filenya, "r") as baca:
    baca = baca.read()
    with open(filenya, "w") as tulis:
     baca=baca.replace(dari, jadinya)
     tulis.write(baca)
