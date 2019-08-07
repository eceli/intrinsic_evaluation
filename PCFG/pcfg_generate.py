#https://gitlab.cl.uni-heidelberg.de/will/nlmaps-gan/blob/852918a3d78b6e6bca3cb8c5310a853533e47063/nlmaps_gan/utils/pcfg_generate.py

from nltk.grammar import Nonterminal, PCFG
import numpy as np
from nltk.parse.generate import generate
from nltk import PCFG

class DepthExceeded(Exception):
    pass


def pcfg_generate(grammar, start=None, depth=None, n=None):
    """Generates an iterator of all sentences from a CFG.

    :param grammar: The PCFG used to generate sentences.
    :param start: The Nonterminal from which to start generating sentences.
    :param depth: The maximum depth of the generated tree.
    :param n: The maximum number of sentences to return.
    :return: An iterator of lists of terminal tokens.
    """
    if not isinstance(grammar, PCFG):
        raise TypeError('grammar must be an instance of PCFG')

    if not start:
        start = grammar.start()
    if depth is None:
        depth = math.inf
    if n is None:
        n = math.inf

    count = 0
    while count < n:
        try:
            sentence = _pcfg_generate_from_several(grammar, [start], depth)
        except DepthExceeded:
            sentence = None
        if sentence:
            count += 1
            yield sentence


def _pcfg_generate_from_several(grammar, items, depth):
    if items:
        return (_pcfg_generate_from_one(grammar, items[0], depth)
                + _pcfg_generate_from_several(grammar, items[1:], depth))
    else:
        return []


def _pcfg_generate_from_one(grammar, item, depth):
    if depth > 0:
        if isinstance(item, Nonterminal):
            prod = _choose_prod(grammar.productions(lhs=item))
            return _pcfg_generate_from_several(grammar, prod.rhs(),
                                               depth=depth - 1)
        else:
            return [item]
    else:
        raise DepthExceeded


def _choose_prod(prods):
    return np.random.choice(prods, p=[prod.prob() for prod in prods])



