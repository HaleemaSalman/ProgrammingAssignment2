## This function creates a special "matrix" object that can cache its inverse.

##There are two functions makeCacheMatrix,makeCacheMatrix
##makeCacheMatrix consists of set,get,setinv, getinv
##library(MASS) is used to calculate inverse for non squared as well as square matrices
library(MASS)
makeCacheMatrix <- function(x = matrix()) {
  inv<-NULL            #initializing inverse as NULL
  set<-function(y){
                  x<<-y
                  inv<<-NULL
                   }
  get<-function()x             #function to get matrix x
  setinv<-function(inverse)inv<<-inverse
  getinv<-function(){ 
                    inver<-ginv(x)
                    inver%*%x           #function to obtain inverse of the matrix
                    }
  list(set = set, get = get, 
       setinv = setinv, 
       getinv = getinv)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above.
## If the inverse has already been calculated (and the matrix has not changed), 
## then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) ##gets cache data      
  {
  inv<-x$getinv()                  
  if(!is.null(inv)){                 #checking whether inverse is NUll 
                     message("getting cached data!")
                     return(inv)                       #returns inverse value
  }
  data<-x$get()
  inv<-solve(data,...)              #calculates inverse value
  x$setinv(inv)
  inv   ## Return a matrix that is the inverse of 'x'
}
