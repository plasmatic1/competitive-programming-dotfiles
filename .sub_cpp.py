import sys
import re
import itertools

flatten = itertools.chain.from_iterable

def get_args(s):
    res = []
    cur = ''
    lay = 0
    for c in s:
        if c in '([{<': lay += 1
        elif c in ')]}>': lay -= 1
        if c == ',' and lay == 0:
            res.append(cur.strip())
            cur = ''
        else:
            cur += c
    res.append(cur.strip())
    return res

def bracket(x):
    return map(lambda x: '(' + x + ')', x)

line = sys.argv[1]
spl = line.strip().split()
cmd = spl[0]
args = get_args(' '.join(spl[1:]))
out = ''

l_space = re.match(r'^(\s*)', line).group(1)  # Leading whitespace 

if cmd == 'for':  # For loops
    opt, st, en, *jmp = args

    var = next(reversed(sorted(opt)))  # lowercase after uppercase.  Variable is assumed lowercase
    cmp = '>' if 'R' in opt else '<'
    if 'I' in opt:
        cmp += '='

    jmp = jmp[0] if jmp else f'{var}++'
    out = f'for (auto {var} = {st}; {var} {cmp} {en}; {jmp})'
elif cmd == 'inn':  # Scanning temporary variables
    out = ', '.join(args) + '\n' + \
            'cin >> ' + ' >> '.join(map(lambda x: x.split()[-1], filter(bool, flatten(map(lambda a: a.split(';'), args))))) + ';'
elif cmd == 'in':   # Scanning values
    out = 'cin >> ' + ' >> '.join(bracket(args)) + ';'
elif cmd == 'print':  # Printing values
    out = 'cout << ' + ' << \' \' << '.join(bracket(args)) + ' << \'\\n\';'
elif cmd == 'op':  # Operator overloading
    cls, op = map(lambda x: x.strip(), args)
    if op in ['<', '>', '<=', '>=', '==']:
        out = f'bool operator{op}(const {cls} &o) const {{'
    elif op in ['<<', '>>']:
        o_typ = ('istream', 'ostream')[op == '<<']
        o_name = ('in', 'out')[op == '<<']
        out = f'{o_typ}& operator{op}({o_typ} &{o_name}, const {cls} o) {{'
    else:
        out = f'sorry operator {op} not supported'
elif cmd == 'dbout':  # Debug output operators
    cls, *props = map(lambda x: x.strip(), args)

    o_vals = []
    prefix = '('
    for prop in props:
        o_vals.append(f'"{prefix}{prop}="')
        o_vals.append(f'o.{prop}')
        prefix = ', '
    o_vals.append('")"')

    out = f'ostream& operator<<(ostream& out, const {cls} o) {{\n' + \
            f'    out << {" << ".join(o_vals)};\n' + \
            f'    return out;\n' + \
            f'}}'
elif cmd == 'db':  # Debug O.o
    out = ''
    for arg in args:
        argspl = arg.split(':')
        if len(argspl) == 1:
            val = argspl[0]
            out += f'cout << "{val}=" << ({val}) << ", ";\n'
        else:
            a_type, *a_vals, val = argspl
            if a_type == 'a':
                out += f'cout << "{a_vals[0]}=" << ({val}) << ", ";\n'
            elif a_type == 'b':
                out += f'cout << "{val}=" << (bitset<{a_vals[0]}>({val})) << ", ";\n'
            elif a_type == 'I':
                out += f'cout << "{val}=[";\n' + \
                       f'for (auto x : {val}) cout << x << ", ";\n' + \
                        'cout << "], ";\n'
            elif a_type == 'A':
                out += f'cout << "{val}=[";\n' + \
                       f'for (int i = 0; i < {a_vals[0]}; i++) cout << {val}[i] << ", ";\n' + \
                        'cout << "], ";\n'
            else:
                out = f'Invalid debug modifiers a_type={a_type}, a_vals={a_vals}, val={val}'
                break
    out += 'cout << endl;'
else:
    out = f'unknown command "{cmd}" with args {args}'

print(l_space + out.replace('\n', '\n' + l_space), end='')

