Practical 2: The prisoner problem simulation

This practical uses stochastic simulation to investigate a somewhat surprising probability puzzle. Along the
way it makes an important statistical point about how badly wrong it is possible to go by assuming events, or
random variables, are independent when they are not.

The puzzle set up is as follows (‘number’ means ‘natural number’ here):

• 2n prisoners each have a unique prisoner number from 1 to 2n.

• The prison contains a room in which there are 2n boxes, each with a unique number from 1 to 2n painted
on its lid.

• 2n cards, each printed with a unique number from 1 to 2n, are randomly placed one in each box.

• The prisoners have the task of finding the card with their number on it by opening a maximum on n boxes.

• After each prisoner’s go, the room is returned exactly to its original state and the prisoner is not allowed to
communicate with prisoners yet to have their go.

• If all prisoners succeed in finding their number, then they all go free.

One of the following strategies has a surprisingly high probability of allowing all prisoners to go free:

1. The prisoner starts at the box with their number on it, opens it and reads the number on the card: k, say. 
If k is not their prisoner number, they go to box number k, open it and repeat the process until they have either
found the card with their number on it, or opened n boxes without finding it.

2. As strategy 1, but starting from a randomly selected box.


3. They open n boxes at random, checking each card for their number.


Your task is to write well structured, well commented, code to estimate the probabilities of success for a single
prisoner under each strategy (that is, what is the probability that one prisoner finds their number), and then for all
prisoners to succeed so that they are freed. You will then write code to estimate a probability distribution that is
key to understanding the surprising result.

1. Write a function Pone to estimate the probability of a single prisoner succeeding in finding their number.
The function takes arguments n, k, strategy and nreps. nreps is the number of replicate simulations
to run in order to estimate the probability (10000 is a reasonable default). The function should return the
probability estimate.

2. Write a function Pall to estimate the probability of all prisoners finding their number, so that all are
released. This has the same arguments as Pone, except for k, of course. Make sure that your code is
structured so that you do not un-necessarily repeat code between the two functions, and it is clear to read.

3. Provide example code using your functions to estimate the individual and joint success probabilities under
each strategy for n = 5 and for n = 50.

4. Include in your comments brief remarks on what is surprising about the results.

5. The surprisingly good strategy works because of the presence of loops in the sequence of cards in boxes. A
loop occurs when some card in the sequence of opened boxes (under strategy 1 or 2) has the number of the
first box opened. Suppose that u is a 2n-vector, such that u[i] gives the number of the card in box number
i. Formally a loop occurs when u[u[· · · u[u[k]] · · · ]] = k, where the length of loop is given by the depth of
nesting. For example u[k] = k is a loop of length 1, u[u[k]] = k is a loop of length 2, u[u[u[k]]] = k is a
loop of length 3, and so on.
Write a function dloop to estimate, by simulation, the probability of each loop length from 1 to 2n occurring at 
least once in a random shuffling of cards to boxes. The functions should take n and nreps as
arguments, and return a 2n-vector of probabilities.

6. Provide example code using dloop to estimate the probabilities for n = 50, assessing the probability that
there is no loop longer than 50 in a random reshuffling of cards to boxes, and also visualising the probabilities
sensibly.

