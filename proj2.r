#name ; university user name ; 
#Shiyu Cai ; s2307982
#Yifan Wu ; s2316499
#Yifan Cai ; s2301729

#github repo:https://github.com/ShiyuCai-Sierra/sp.project2.git

#Shiyu Cai: Write Pone and Pall function of the first two strategies. Provide example code.
#Yifan Wu: Write dloop function and use it to estimate the probabilities. Visualization of the probabilities.
#Yifan Cai: Write Pone and Pall function of the third strategies. Provide example code. Organize the framework of the entire code.

#outline:
#In this code file, we are trying to simulate the prisoner problem by using three different strategies and find the best of the three. 
#The prisoner problem is that we let 2n prisoners who have their own specific number walk into a room with 2n boxes and each box contains a random number ranging from 1 to 2n to find the card with their own number.
#Every prisoner can only open up to n boxes. The prisoner is not allow to communicate with other prisoners and only when all prisoners find the correct cards, they all go free.
#And also, we write a function to estimate the probability of each loop length which occurs because some card in the sequence of open boxes has the number of the first box opened.

#We divide the whole content into three parts.
#In the first part (Part one), we write three different strategies to simulate the problem.
#In the second part (Part two), we write function Pone to estimate the probability of a single prisoner succeeding in finding their number under three strategies.
#Besides, we write function Pall to estimate the probability of all 2n prisoners finding the card with their numbers within n trials.
#And also includes the example codes for every strategy.
#In the third part(Part three), we write function find_loop_length to help find the loop length.
#And we write function dloop which is used to find the probability of loop length from 1 to 2n occurring at least once
#The third one is find_prob which is for finding the probability that loop length no loop longer than 50.
#At last, we draw bar chart to visualize the probabilities.


##Part one 
Strategy_1 <- function(n, k, boxes){
  '
  Strategy_1(n, k, boxes)
    This function is to determine whether a prisoner is temporarily successful in using strategy_1.
  
  input:
    n(int): half number of unique prisoner, boxes or lids and also is the maximum times for one prisoner to try
    k(int): the number of the prisoner 
    boxes(int): 2n random card numbers in 1 to 2n boxes
    
  output: 
    success_or_not(int): 1 implies the prisoner succeeded; 0 implies the prisoner failed 
  '
  ##set the initial condition of whether the prisoner succeed or not(0 implies the prisoner failed; 1 implies the prisoner succeeded)
  success_or_not <- 0
  ##the maximum trail times is n
  times <- n 
  ## the first box the prisoner choose is the same as the number of the prisoner that is k
  num_of_box <- k 
  ##the prisoner starts to trail within n times
  for (t in 1:times){
    ##the number of next box the prisoner chooses is equal to the number of card inside the former box 
    num_of_box <- boxes[num_of_box]
    ##if the card in former box is equal to the number of prisoner,this trail is successful and let's enter into the next trail
    if (num_of_box == k){
      success_or_not <- 1
      break
    } 
  }
  ## let's return whether the prisoner succeed
  success_or_not
}

Strategy_2 <- function(n, k, boxes){
  '
  Strategy_2(n, k, boxes)
    This function is to determine whether a prisoner is temporarily successful in using strategy_2.
  
  input:
    n(int): half number of unique prisoner, boxes or lids and also is the maximum times for one prisoner to try
    k(int): the number of the prisoner 
    boxes(int): 2n random card numbers in 1 to 2n boxes
    
  output: 
    success_or_not(int): 1 implies the prisoner succeeded; 0 implies the prisoner failed 
  '
  
  ##set the initial condition of whether the prisoner succeed or not(0 implies the prisoner failed; 1 implies the prisoner succeeded)
  success_or_not <- 0
  ##the maximum trail times is n
  times <- n 
  ## the prisoner randomly choose the first box's number 
  num_of_box <- sample(1:(2*n), 1, replace = TRUE) 
  for (t in 1:times){
    ##the number of next box the prisoner choose is equal to the number of card inside the former box 
    num_of_box <- boxes[num_of_box]
    ##if the card in former box is equal to the number of prisoner,this trail is successful and let's enter into the next trail
    if (num_of_box == k){
      success_or_not <- 1
      break
    } 
  }
  ## let's return whether the prisoner succeed
  success_or_not
}

Strategy_3 <- function(n, k, boxes){
  '
  Strategy_3(n, k, boxes)
    This function is to determine whether a prisoner is temporarily successful in using strategy_3.
  
  input:
    n(int): half number of unique prisoner, boxes or lids and also is the maximum times for one prisoner to try
    k(int): the number of the prisoner 
    boxes(int): 2n random card numbers in 1 to 2n boxes
    
  output: 
    success_or_not(int): 1 implies the prisoner succeeded; 0 implies the prisoner failed 
  '
  ##set the initial condition of whether the prisoner succeed or not(0 implies the prisoner failed; 1 implies the prisoner succeeded)
  success_or_not <- 0
  ## the prisoner opens n boxes at random
  boxes_taken <- sample(boxes, n) 
  ## now the prisoner checks each card for their own number
  ##if the prisoner find his/her own number in n boxes,this trail is successful and let's enter into the next trail
  if (k %in% boxes_taken){ 
    success_or_not <- 1
  }
  ## let's return whether the prisoner succeed
  success_or_not
}

##Part two
Pone <- function(n, k, strategy, nreps = 10000){
  '
  Pone(n, k, strategy, nreps )
    This function is to estimate the probability of a single prisoner succeeding in finding their number.
  
  input:
    n(int): half number of unique prisoner, boxes or lids and also is the maximum times for one prisoner to try
    k(int): the number of the prisoner 
    strategy(int): number of chosen strategy 
    nreps(int): the simulation times (10000 is set as a default)
    
  output: 
    probability_of_one(float): the probability estimate
  '
  
  
  ##for the condition of using strategy one
  if (strategy == 1){
    ##loop the condition in every one trail of nreps trails
    ## define the initial number of successful trails
    num_of_success_all <- 0 
    for (i in 1:nreps){
      ##box number is from 1 to 2n, but we shuffle the order of cards in each box
      boxes <- sample(1:(2*n), 2*n)
      ##record the number of successes in nreps trails
      num_of_success_all <- num_of_success_all + Strategy_1(n, k, boxes)
    }
    ## the final probability of one prisoner being successful can be calculated by the number of successful trails divided by total simulation times
    probability_of_one <- num_of_success_all / nreps
  }
  
  ##for the condition of using the second strategy
  if (strategy == 2){
    ##loop the condition in every one trail of nreps trails
    ## define the initial number of successful trails
    num_of_success_all <- 0 
    for (i in 1:nreps){
      ##box number is from 1 to 2n, but we shuffle the order of cards in each box
      boxes <- sample(1:(2*n), 2*n)
      ##record the number of successes in nreps trails
      num_of_success_all <- num_of_success_all + Strategy_2(n, k,boxes)
    }
    ## the final probability of one prisoner being successful can be calculated by the number of successful trails divided by total simulation times
    probability_of_one <- num_of_success_all / nreps 
  }
  
  ##for the condition of using the third strategy
  if (strategy == 3) {
    ##loop the condition in every one trail of nreps trails
    ## define the initial number of successful trails
    num_of_success_all <- 0 
    for(i in 1:nreps){
      ##box number is from 1 to 2n, but we shuffle the order of cards in each box
      boxes <- sample(1:(2*n), 2*n)
      ##record the number of successes in nreps trails
      num_of_success_all <- num_of_success_all + Strategy_3(n, k,boxes)
    }
    ## the final probability of one prisoner being successful can be calculated by the number of successful trails divided by total simulation times
    probability_of_one <- num_of_success_all / nreps
  }
  ## let's return what is the probability estimate
  probability_of_one
}  

Pall <- function(n, strategy, nreps = 10000){
  '
  Pall(n, strategy, nreps )
    This function is to estimate the probability of all 2n prisoners finding the card with their numbers within n trials.
  
  input:
    n(int): half number of unique prisoner, boxes or lids and also is the maximum times for one prisoner to try
    strategy(int): number of chosen strategy 
    nreps(int): the simulation times (10000 is set as a default)
    
  output: 
    probability_of_all(float): the probability estimate
  '
  
  ## set initial number of success
  num_of_all_success <- 0 
  ## loop the condition in every one trail of nreps trails
  for (j in 1:nreps) {
    ## record the number of 2n prisoners who successfully found the number
    num_of_all <- 0
    ##box number is from 1 to 2n, but we shuffle the order of cards in each box
    boxes <- sample(1:(2*n), 2*n)
    if (strategy == 1) {
      ##loop the condition in every prisoner of 2n prisoners 
      for (i in 1:(2*n)){
        ##use the function Strategy_1 defined before, and calculate the number of successful prisoners
        num_of_all <- num_of_all + Strategy_1(n, i,boxes)
      }
      ## determine if all prisoners are successful
      if (num_of_all == 2*n) {
        ## if all prisoners are successful, they all go free 
        num_of_all_success <- num_of_all_success + 1
      }
    }
    if (strategy == 2) {
      ##loop the condition in every prisoner of 2n prisoners 
      for (i in 1:(2*n)){
        ##use the function Strategy_1 defined before, and calculate the number of successful prisoners
        num_of_all <- num_of_all + Strategy_2(n, i,boxes)
      }
      ## determine if all prisoners are successful
      if (num_of_all == 2*n) {
        ## if all prisoners are successful, they all go free 
        num_of_all_success <- num_of_all_success + 1
      }
    }
    if (strategy == 3) {
      ##loop the condition in every prisoner of 2n prisoners 
      for (i in 1:(2*n)){
        ##use the function Strategy_1 defined before, and calculate the number of successful prisoners
        num_of_all <- num_of_all + Strategy_3(n, i,boxes)
      }
      ## determine if all prisoners are successful
      if (num_of_all == 2*n) {
        ## if all prisoners are successful, they all go free 
        num_of_all_success <- num_of_all_success + 1
      }
    }
  }
  ## the final probability of all prisoners being successful can be calculated by the number of successful trails divided by total simulation times
  probability_of_all <- num_of_all_success/nreps
  
  ## print the final probability
  cat(probability_of_all)
}

##example codes for every strategy 

##for strategy one, n=5
##individual success probability of prisoner number 8 can be estimate by Pone(5,8,1)
cat(Pone(5,8,1))
##joint success probability can be estimated by Pall(5,1)
cat(Pall(5,1))

##for strategy one, n=5
##individual success probability of prisoner number 8 can be estimate by Pone(5,8,2)
cat(Pone(5,8,2))
##joint success probability can be estimated by Pall(5,2)
cat(Pall(5,2))

##for strategy three, n=5
##individual success probability of prisoner number 8 can be estimate by Pone(5,8,3)
cat(Pone(5,8,3))
##joint success probability can be estimated by Pall(5,3)
cat(Pall(5,3))


##for strategy one, n=50
##individual success probability of prisoner number 8 can be estimate by Pone(50,8,1)
cat(Pone(50,8,1))
##joint success probability can be estimated by Pall(50,1)
cat(Pall(50,1))

##for strategy two, n=50
##individual success probability of prisoner number 8 can be estimate by Pone(50,8,2)
cat(Pone(50,8,2))
##joint success probability can be estimated by Pall(50,2)
cat(Pall(50,2))

##for strategy three, n=50
##individual success probability of prisoner number 8 can be estimate by Pone(50,8,3)
cat(Pone(50,8,3))
##joint success probability can be estimated by Pall(50,3)
cat(Pall(50,3))

#Comments: From the results we can see a significant difference in the probabilities predicted by the three methods, especially when calculating the probability of success for all criminals.
#When the number of prisoners is large, and the probability of success for all is considered, if we consider the way of choosing cards as a dependent behavior, 
#and in the case where the first card is our own number, which is strategy one, we get a surprising result, while the other two methods get a result of 0.

#Part three
find_loop_length <- function(n){
  '
  find_loop_length(n)
    This function is for finding the loop length of each box
  
  input:
    n(int): half number of unique prisoner, boxes or lids
    
  output: 
    loop_len_list(int): loop length of each box, and the length of list equal to 2n
  '
  
  #create an empty list for store the loop length of each box
  loop_len_list <- c() 
  # Use the sample function to initialize the number of the lid in each box
  u <- sample(1:(2*n), 2*n) 
  # use loop to search the loop length for all box
  for (j in 1:(2*n)){
    # initialize the loop length
    # if firstly the lid and box numbers are the same then output directly
    loop_len <- 1
    k <- u[j] 
    
    # find the loop length for each box
    while (j != u[j] & loop_len < length(u)){	 
      # if the lid and box numbers are the same, loop length increased by 1 and stop loop
      if (u[k] == j){ 
        loop_len <- loop_len + 1
        break
      }
      # if the lid and box numbers are the different, 
      # make the code of the next box the same as the code of the lid
      # and loop length increased by 1 
      else{
        k <- u[k]
        loop_len <- loop_len + 1
      }
    }
    #Add the loop length of each length to the list for storage
    loop_len_list <- append(loop_len_list, loop_len)
    
  }
  loop_len_list
}


dloop <- function(n, nreps){
  '
  dloop(n, nreps)
    This function is for finding the probability of loop length from 1 to 2n occurring at least once
  
  input:
    n(int): half number of unique prisoner, boxes or lids
    nreps(int): number of simulations
  
  output:
    prob_list(float): probability of loop length(occuring times >= 1), 
    and the length of list equal to 2n
  '
  
  # create an empty list to store the frequency of each occurrence of different loop lengths
  freq_list <- rep(0, (2*n))
  # do the simulation
  for (i in 1:nreps){ 
    # use function to find the loop length of all boxes
    loop_len_list <- find_loop_length(n)
    # create an empty list, limited to 2n, to store frequency of the loop length and 
    # avoid mismatching the output length of the tabulate function
    loop_len_freq <- rep(0, (2*n))
    # count the length of the tabulate function
    freq_len <- length(tabulate(loop_len_list))
    # store the final frequency of each loop length 
    loop_len_freq[1:freq_len] <- tabulate(loop_len_list)
    #If a loop length occurs more than once in a simulation, the frequency is increased by 1
    freq_list[loop_len_freq >= 1] <- freq_list[loop_len_freq >= 1] +1
  }
  
  #The probability is obtained by dividing the frequency by the total number of simulations
  prob_list <- freq_list/nreps
  prob_list
}

#output the loop length list for given value of n and nreps
#dloop(50, 10000)

#Initialize the values of n and nreps
n <- 50 
nreps <- 10000

#create a list between 1 and 100 for x coordinate axis
n_list <- c(1:(2*n)) 
#create a list to store the probability of loop length for ycoordinate axis
prob_list <- dloop(n,nreps) 

find_prob <- function(n, nreps){
  '
  find_prob(n, nreps)
    This function is for finding the probability that loop length no loop longer than 50
  
  input:
    n(int): half number of unique prisoner, boxes or lids
    nreps(int): number of simulations
  
  output:
    prob_list(float): probability of loop length no loop longer than 50
  '
  
  freq <- 0 #Initialize the values of frequency
  # use loop to do the simulation to count frequency that loop length no loop longer than 50
  for (i in 1:nreps){ 
    # use function to find the loop length of all boxes
    loop_len_list <- find_loop_length(n) 
    # create an empty list, limited to 2n, to store frequency of the loop length and 
    # avoid mismatching the output length of the tabulate function
    loop_len_freq <- rep(0, (2*n))
    # count the length of the tabulate function
    freq_len <- length(tabulate(loop_len_list))
    # store the final frequency of each loop length 
    loop_len_freq[1:freq_len] <- tabulate(loop_len_list)
    # select an array of frequencies with loop length greater than 50
    loop_count_50a <- loop_len_freq[(n+1) : (2*n)] 
    # If loop lengths greater than 50 do not occur, increase the frequency by 1
    if (sum(loop_count_50a) == 0) {
      freq <- freq+1 
    }
  }
  
  #The probability is obtained by dividing the frequency by the total number of simulations
  prob <- freq/nreps 
  prob
}

#output the probability for given value of n and nreps
find_prob(50, 10000) 
#draw the bar chart to show the relationship of probability and loop length
barplot(prob_list~n_list, xlab='loop length',ylab='probability') 