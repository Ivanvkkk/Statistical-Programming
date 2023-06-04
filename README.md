# Practical 2: The prisoner problem simulation

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


