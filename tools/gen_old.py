#!python3
import subprocess as sub
from string import *
from random import *

lim = 100
def gr():
    return randint(1, lim)
def ts(x):
    return tuple(sorted(x))


sub.call(['g++', 'temple-construction.cpp', '-o', 'fast'])
sub.call(['g++', 'slow.cpp', '-o', 'slow'])

T = 10000

def g(N):
    a, b = N, N
    while a == b:
        a = randint(1, N)
        b = randint(1, N)
    return a, b

def cross(p1, p2):
    return p1[0] * p2[1] - p1[1] * p2[0]
def colinear(pts):
    n = len(pts)
    for i in range(n):
        for j in range(n):
            if i == j: continue
            for k in range(n):
                if k == i or k == j: continue
                p1 = (pts[j][0] - pts[i][0], pts[j][1] - pts[i][1])
                p2 = (pts[k][0] - pts[i][0], pts[k][1] - pts[i][1])
                if cross(p1, p2) == 0:
                    return True
    return False

for cno in range(T):
    N = 7
    R = randint(1, 100)
    pts = []
    while len(set(pts)) != N or colinear(pts):
        pts = [(randint(1, 10), randint(1, 10)) for _ in range(N)]

    inp = f'{N} {R}\n'
    for x, y in pts:
        inp += f'{x} {y}\n'

    ans = sub.run(['./slow'], stdout=sub.PIPE, stderr=sub.PIPE, text=True, input=inp).stdout.strip()
    # ans = ''
    out = sub.run(['./fast'], stdout=sub.PIPE, stderr=sub.PIPE, text=True, input=inp).stdout.strip()

    def shoe2(pts):
        res = 0
        for i in range(len(pts)):
            n = (i+1)%len(pts)
            res += pts[i][0] * pts[n][1] - pts[i][1] * pts[n][0]
        return abs(res)
    def getans(output):
        return abs(shoe2([pts[int(x) - 1] for x in output.split()]) - 2*R)

    # ans = str(getans(ans))
    # out = str(getans(out))

    # out = out.split()
    # bad = out[1] if 'ERR' in out else False 
    # bad = out.split() != ans.split()
    bad = getans(ans) != getans(out)

    if bad:
        print(f'Case wrong: inp: "{inp}"')
        print(f'Got \n{out}, expect \n{ans}')
        print(f'err: {bad}')
        exit(0)
    else:
        print(f'Passed case {cno}')

