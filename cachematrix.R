# These functions introduce a special matrix object which caches its inverse.
# Create a special "matrix" object that can cache its inverse.
#' Returns list that contains 4 functions to get the inverse of a matrix
makeCacheMatrix <- function(x = matrix()) { #define the function
    m <- NULL
    # Define function to set the value of the matrix. It also clears the old
    # inverse from the cache
    set <- function(y) {
        x <<- y    # Set the value
        m <<- NULL # Clear the cache
    }
    # Define function to get the value of the matrix
    get <- function() x
    # Define function to set the inverse. This is only used by getinverse() when
    # there is no cached inverse
    setInverse <- function(inverse) m <<- inverse
    # Define function to get the inverse
    getInverse <- function() m
    
    # Return a list with the above four functions
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}

#' Return inverse of matrix x
#' This function computes the inverse of the special "matrix" returned by 
#' makeCacheMatrix above. If the inverse has already been calculated then the cachesolve retrieves the inverse from the cache.

cacheSolve <- function(x) {
  inv <- x$getInverse() # This fetches the cached value for the inverse
  if(!is.null(inv)) { # If the cache was not empty, we can just return it
    message("getting cached data")
    return(inv)
  }
  # The cache was empty. We need to calculate it, cache it, and then return it.
  data <- x$get()  # Get value of matrix
  inv <- solve(data) # Calculate inverse
  x$setInverse(inv)  # Cache the result
  return(inv)                # Return the inverse
}
