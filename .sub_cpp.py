import sys
import re
import itertools

flatten = itertools.chain.from_iterable

def get_args(s):
    res = []
    cur = ''
    pre = ''
    lay = 0
    for c in s:
        if c in '([{<': lay += 1
        elif c in ')]}>':
            if c != '>' or pre != '-':  # -> Operator
                lay -= 1
        if c == ',' and lay == 0:
            res.append(cur.strip())
            cur = ''
        else:
            cur += c
        pre = c
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

# Separator for debugging
db_sep = ' '

if cmd == 'for':  # For loops
    opt, st, en, *jmp = args

    var = next(reversed(sorted(opt)))  # lowercase after uppercase.  Variable is assumed lowercase
    cmp = '>' if 'R' in opt else '<'
    if 'I' in opt:
        cmp += '='

    jmp = jmp[0] if jmp else (f'{var}++' if 'R' not in opt else f'{var}--')
    out = f'for (auto {var} = {st}; {var} {cmp} {en}; {jmp})'
elif cmd == 'inn':  # Scanning temporary variables
    out = ', '.join(args).rstrip(';') + '; ' + \
            'cin >> ' + ' >> '.join(map(lambda x: x.split()[-1], filter(bool, flatten(map(lambda a: a.split(';'), args))))) + ';'
elif cmd == 'in':   # Scanning values
    out = 'cin >> ' + ' >> '.join(args) + ';'
elif cmd == 'print':  # Printing values
    out = 'cout << ' + ' << \' \' << '.join(bracket(args)) + ' << \'\\n\';'
elif cmd == 'op':  # Operator overloading
    cls, op, *o_args = map(lambda x: x.strip(), args)
    if op in ['<', '>', '<=', '>=', '==']:
        out = f'bool operator{op}(const {cls} &o) const {{'
    elif op in ['<<', '>>']:
        o_typ = ('istream', 'ostream')[op == '<<']
        o_name = ('in', 'out')[op == '<<']
        obj_var = (f'{cls} &o', f'const {cls} o')[op == '<<']
        out = f'{o_typ}& operator{op}({o_typ} &{o_name}, {obj_var}) {{'
    elif op == 'cmp':
        out = f'bool {o_args[0]}(const {cls} a, const {cls} b) {{'
    elif op == 'cmpfn':
        out = f'bool operator()(const {cls} a, const {cls} b) const {{'
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
            out += f'cout<<"{val}="<<({val})<<", ";{db_sep}'
        else:
            a_type, *a_vals, val = argspl
            if a_type == 'l':  # Label
                out += f'cout<<"[{val}]: ";{db_sep}'
            elif a_type == 'a':  # Alias
                out += f'cout<<"{a_vals[0]}="<<({val})<< ", ";{db_sep}'
            elif a_type == 'b':  # Bits
                out += f'cout<<"{val}="<<(bitset<{a_vals[0]}>({val}))<<", ";{db_sep}'
            elif a_type == 'I':  # Iterable
                out += f'cout << "{val}=[";{db_sep}' + \
                       f'for (auto __x:{val})cout<<__x<<", ";{db_sep}' + \
                       f'cout<<"], ";{db_sep}'
            elif a_type == 'A':  # Array
                out += f'cout<<"{val}=[";{db_sep}' + \
                       f'for(int __i=0; __i<({a_vals[0]}); __i++)cout<<{val}[__i]<<", ";{db_sep}' + \
                       f'cout<<"], ";'
            else:
                out = f'Invalid debug modifiers a_type={a_type}, a_vals={a_vals}, val={val}'
                break
    out += f'cout << endl; // {line.strip()}'
else:
    out = f'unknown command "{cmd}" with args {args}'

print(l_space + out.replace('\n', '\n' + l_space), end='')

