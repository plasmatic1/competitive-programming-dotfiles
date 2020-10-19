#!python3
import subprocess as sub
from string import *
from random import *

lim = 100
def gr():
    return randint(1, lim)
def ts(x):
    return tuple(sorted(x))


sub.call(['g++', 'dmopc-20-contest-1-p5.cpp', '-o', 'fast'])
sub.call(['g++', 'slow.cpp', '-o', 'slow'])

T = 500000

def g(N):
    a, b = N, N
    while a == b:
        a = randint(1, N)
        b = randint(1, N)
    return a, b

for cno in range(1, T):
    N = 1000
    K = N
    Q = 1000

    inp = f'{N} {K} {Q}\n'
    inp += " ".join([str(randint(1, K)) for _ in range(N)]) + '\n'
    for i in range(2, N + 1):
        inp += f'{randint(1, i - 1)} {i}\n'
    for i in range(Q):
        t = randint(1, 2)
        # t = 2
        if t == 1:
            inp += f'1 {randint(1, N)} {randint(1, N)}\n'
        else:
            inp += f'2 {randint(1, N)}\n'

    ans = sub.run(['./slow'], stdout=sub.PIPE, stderr=sub.PIPE, text=True, input=inp).stdout.strip()
    # ans = ''
    out = sub.run(['./fast'], stdout=sub.PIPE, stderr=sub.PIPE, text=True, input=inp).stdout.strip()

    # ans = str(getans(ans))
    # out = str(getans(out))

    # out = out.split()
    # bad = out[1] if 'ERR' in out else False 
    bad = out.split() != ans.split()
    # bad = out.stderr if out.returncode else None

    if bad:
        print(f'Case wrong: inp: "{inp}"')
        print(f'Got \n{out}, expect \n{ans}')
        print(f'err: {bad}')
        exit(0)
    else:
        print(f'Passed case {cno}')

