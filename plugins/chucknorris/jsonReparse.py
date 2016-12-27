import json
import sys

DIR = sys.argv[1]
with open(DIR+'/fortunesinetjokes','w') as of:
    for line in sys.stdin:
        jokes = json.loads(line)
        jokes = jokes['value']
        for j in jokes:
            s = j['joke'].encode('iso-8859-15')
            s = s.replace('&quot;','"')
            of.write(s+'\n%\n')
