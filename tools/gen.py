#!/bin/python3
import subprocess as sub
from string import *
from random import *

lim = 100
def gr():
    return randint(1, lim)
def ts(x):
    return tuple(sorted(x))


sub.call(['g++', 'bobs-strategy-game.cpp', '-o', 'fast'])
sub.call(['g++', 'slow.cpp', '-o', 'slow'])

T = 1000

def g(N):
    a, b = N, N
    while a == b:
        a = randint(1, N)
        b = randint(1, N)
    return a, b

for cno in range(T):
    N = 50
    M = min(N * (N - 1) // 2, N * 2)
    K = N // 2

    inp = f'1\n{N} {M}\n'
    HAS = set()
    for i in range(M):
        tp = g(N)
        while ts(tp) in HAS:
            tp = g(N)
        HAS.add(ts(tp))
        inp += f'{tp[0]} {tp[1]}\n'
    inp += f'1\n{K} '
    HAS.clear()
    for i in range(K):
        n = randint(1, N)
        while n in HAS:
            n = randint(1, N)
        HAS.add(n)
        inp += f'{n} '

    ans = sub.run(['./slow'], stdout=sub.PIPE, stderr=sub.PIPE, text=True, input=inp).stdout.strip()
    # ans = ''
    out = sub.run(['./fast'], stdout=sub.PIPE, stderr=sub.PIPE, text=True, input=inp).stdout.strip()

    # out = out.split()
    # bad = out[1] if 'ERR' in out else False 
    bad = out.split() != ans.split()

    if bad:
        print(f'Case wrong: inp: "{inp}"')
        print(f'Got \n{out}, expect \n{ans}')
        print(f'err: {bad}')
        exit(0)
    else:
        print(f'Passed case {cno}')

