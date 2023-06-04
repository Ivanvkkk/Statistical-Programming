## Code to simulate the prison number location problem.
## The challenge is that there 2*n prisoners each numbered 1:(2*n).
## In a room are 2*n boxes each labelled 1:(2*n). Each box contains
## a card with one of the numbers 1:(2*n) written on it.
## The cards have been randomly shuffled to boxes.
## Each prisoner is allowed to open n boxes. They
## succeed if they find the card with their number on it. After each 
## prisoner's go, the room is returned to exactly its initial state.
## If all prisoners succeed then they will go free. They can not
## communicate with other prisoners while in the room or afterwards.
## 3 strategies are suggested:
## 1. Each prisoner starts at the box with their number on it. They open the box,
##    take out the card and then open the box corresponding to the number on the
##    card. They repeat this process until they find their number or have opened
##    n boxes without finding it.
## 2. As 1 but starting at a randomly chosen box.
## 3. They simply open n boxes at random.
## The code here investigates the probability of a single prisoner succeeding
## under each strategy, and then the probability that they all succeed. 


prisoner <- function(k,u,strategy=1) {
## simulate one prisoner playing one of 3 strategies:
## Strategy 1
## 1. Start with the box with their number on it,
## 2. if it doesn't contain their number open the box corresponding to the number it does contain
## 3. repeat 2.
## Strategy 2 - as strategy 1, but starting from a random box.
## Strategy 3 - open n boxes at random until success (find your number), or n turns is up.
## k is the prisoner number. u is a vector representing the boxes. i.e. u[i] is the number contained
## in box number i. 
  n <- length(u)/2 ## number of boxes allowed to be opened
  ok <- 0; ## indicator of fail (0) or success (1)
  k0 <- k  ## copy of prisoner number
  if (strategy>1) k <- sample(1:(2*n),1) ## starting box for strategy 2
  if (strategy < 3) for (i in 1:n) { ## loop working through boxes
    if (u[k]==k0) { ## success prisoner number located in a box
      ok <- 1;break; ## box contains prisoner number
    } else k = u[k] ## next box to try
  } else { ## prisoner just tries boxes at random
    if (any(u[sample(1:(2*n),n)]==k0)) ok <- 1
  }
  ok ## return result
} ## prisoner

Pone <- function(k=1,n=50,strategy=1,nreps=10000) {
## compute approximate probability of a single prisoner succeeding, by simulation
## k is prisoner number, out of 2*n prisoners. nreps is number of attempts to
## simulate. 
  ok <- 0 ## counter for number of successful attempts
  for (j in 1:nreps) { ## replicate attempts
    u <- sample(1:(2*n),2*n) ## shuffle numbers to boxes
    ok <- ok + prisoner(k,u,strategy) ## play strategy and record success or not
  }
  ok/nreps ## estimated P(success)
} ## Pone

Pall <- function(n=50,strategy=1,nreps=10000) {
## simulate process of all 2*n prisoners attempting to find their number
## when all playing one of the 3 strategies
  ok <- 0 ## count of number of times all are sucessful.
  for (j in 1:nreps) { ## replicate all prisoners attempting task
    u <- sample(1:(2*n),2*n) ## shuffle keys to boxes
    ok.all <- TRUE ## have all prisoners succeeded?
    for (i in 1:(2*n)) { ## prisoner loop
      if (!prisoner(i,u,strategy)) { ## each prisoner plays
        ok.all <- FALSE;break ## one failed, so all fail
      }
    }
    if (ok.all) ok <- ok + 1 ## count up all succeeded
  }
  ok/nreps
} ## Pall


n <- 5;Pone(1,n,1);Pone(1,n,2);Pone(1,n,3);
Pall(n,1);Pall(n,2);Pall(n,3);
## strategies 2 and 3 give probabilities expected from product of
## individual probabilities - not strategy 1!

n <- 50;Pone(1,n,1);Pone(1,n,2);Pone(1,n,3);
Pall(n,1);Pall(n,2);Pall(n,3);
## same result, but even more dramatic.

## loop distribution

dloop <- function(n=50,nreps=100000) {
## obtain the distribution of loop lengths in random shuffles of
## digits 1:(2*n). Probability that a loop of a given length
## occurs at least once in a random shuffle is the target.
## If u contains the shuffled digits a loop is
## a seqence u[u[...u[u[k]]...]] = k. e.g. u[k] = k is a 1-loop
## u[u[k]]=k is a 2-loop etc. 
  d <- rep(0,2*n) ## vector for counting loop lengths 
  for (j in 1:nreps) { ## replicate simulation loop
    d0 <- rep(0,2*n) ## indicator for whether a loop of each length found 
    u <- sample(1:(2*n),2*n) ## shuffle digits to locations in u
    tried <- rep(FALSE,length(u)) ## keep track of elements not tried yet
    repeat { ## work through all loops in current u
      i0 <- min(which(!tried)) ## next un-tried loop start to try
      k0 <- k <- u[i0]; i<-1;tried[i0] <- TRUE ## first entry in loop
      while (u[k]!=k0) { ## follow loop back to start
        i <- i + 1 ## increment loop length counter
	k <- u[k];tried[k] <- TRUE
      }
      d0[i] <- 1 ## found a loop of length i in this replicate 
      if (all(tried)) break
    }
    d <- d + d0
  }
  d/nreps
} ## dloop

nreps <- 100000
d <- dloop(nreps=nreps)
1-sum(d[51:100]) ## probability of no loop longer than 50
## ... note this is the same as Probability of all suceeding...
plot(1:(2*n),d,xlab="loop length",ylab="Probability")
## or something based on barplot(d,xlab="loop length",ylab="Probability")