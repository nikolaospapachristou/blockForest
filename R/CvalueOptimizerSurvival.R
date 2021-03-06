CvalueOptimizerSurvival <- 
  setRefClass("CvalueOptimizerSurvival", 
              contains = "CvalueOptimizer", 
              fields = list(), 
              methods = list(
                
                optimizeCvalues = function(...) {
                  
                  if(block.method=="BlockVarSel") {
                    
                    # Number of blocks:
                    M <- length(blocks)
                    
                    # Simulate 'nsets' vectors of c values with the ordering
                    # given by morder,  for each of these construct a forest,
                    # and calculate the corresponding OOB error.
                    # Then use that vector of c values out of the ones generated
                    # for which the corresponding forest featured the smallest
                    # OOB error.
                    
                    errs <- 0
                    cvaluesall <- list()
                    
                    for(l in 1:nsets) {
                      
                      cvalues <- sample(c(sort(runif(M-1)), 1))
                      cvaluesall[[l]] <- cvalues  
                      
                      forest <- blockForest(dependent.variable.name = "time", status.variable.name = "status", 
                                            data = data, num.trees = num.trees.pre,
                                            blocks = blocks,
                                            block.weights = cvalues,
                                            mtry = mtry, keep.inbag = TRUE, block.method=block.method, 
                                            splitrule = splitrule, write.forest = FALSE, ...)
                      
                      errs[l] <- forest$prediction.error
                      
                    }
                    
                    # Optimized vector of c values:
                    cvalues <- cvaluesall[[which.max.random(-errs)]]
                    
                    return(cvalues)
                    
                  }
                  
                  if(block.method=="VarProb") {
                    
                    pm <- sapply(blocks, length)
                    
                    # Number of blocks:
                    M <- length(blocks)
                    
                    # Simulate 'nsets' vectors of c values with the ordering
                    # given by morder,  for each of these construct a forest,
                    # and calculate the corresponding OOB error.
                    # Then use that vector of c values out of the ones generated
                    # for which the corresponding forest featured the smallest
                    # OOB error.
                    
                    errs <- 0
                    cvaluesall <- list()
                    
                    for(l in 1:nsets) {
                      
                      cvalues <- sapply(pm, function(x) sample(c(runif(1, 0, sqrt(x)/x), runif(1, sqrt(x)/x, 1)), size=1))
                      
                      if (always.select.block > 0) {
                        cvalues[always.select.block] <- 1
                      }
                      
                      cvaluesall[[l]] <- cvalues  # split.select.weights
                      
                      splitweights <- rep(NA, sum(pm))
                      for(blocki in seq(along=blocks))
                        splitweights[blocks[[blocki]]] <- cvalues[blocki]
                      
                      forest <- blockForest(dependent.variable.name = "time", status.variable.name = "status", 
                                            data = data, num.trees = num.trees.pre,
                                            split.select.weights = splitweights,
                                            mtry = mtry, keep.inbag = TRUE, block.method=block.method, 
                                            splitrule = splitrule, write.forest = FALSE, ...)
                      
                      errs[l] <- forest$prediction.error
                      
                    }
                    
                    # Optimized vector of c values:
                    cvalues <- cvaluesall[[which.max.random(-errs)]]
                    
                    return(cvalues)
                    
                  }
                  
                  if(block.method=="SplitWeights") {
                    
                    # Number of blocks:
                    M <- length(blocks)
                    
                    # Simulate 'nsets' vectors of c values with the ordering
                    # given by morder,  for each of these construct a forest,
                    # and calculate the corresponding OOB error.
                    # Then use that vector of c values out of the ones generated
                    # for which the corresponding forest featured the smallest
                    # OOB error.
                    
                    errs <- 0
                    cvaluesall <- list()
                    
                    for(l in 1:nsets) {
                      
                      cvalues <- sample(c(sort(runif(M-1)), 1))
                      cvaluesall[[l]] <- cvalues  
                      
                      forest <- blockForest(dependent.variable.name = "time", status.variable.name = "status", 
                                            data = data, num.trees = num.trees.pre,
                                            blocks = blocks,
                                            block.weights = cvalues,
                                            mtry = mtry, keep.inbag = TRUE, block.method=block.method, 
                                            splitrule = splitrule, write.forest = FALSE, ...)
                      
                      errs[l] <- forest$prediction.error
                      
                    }
                    
                    # Optimized vector of c values:
                    cvalues <- cvaluesall[[which.max.random(-errs)]]
                    
                    return(cvalues)
                    
                  }
                  
                  
                  if(block.method=="BlockForest") {
                    
                    # Number of blocks:
                    M <- length(blocks)
                    
                    # Simulate 'nsets' vectors of c values with the ordering
                    # given by morder,  for each of these construct a forest,
                    # and calculate the corresponding OOB error.
                    # Then use that vector of c values out of the ones generated
                    # for which the corresponding forest featured the smallest
                    # OOB error.
                    
                    errs <- 0
                    cvaluesall <- list()
                    
                    for(l in 1:nsets) {
                      
                      cvalues <- sample(c(sort(runif(M-1)), 1))
                      cvaluesall[[l]] <- cvalues  
                      
                      forest <- blockForest(dependent.variable.name = "time", status.variable.name = "status", 
                                            data = data, num.trees = num.trees.pre, 
                                            blocks = blocks,
                                            block.weights = cvalues,
                                            mtry = mtry, keep.inbag = TRUE, block.method=block.method,
                                            splitrule = splitrule, write.forest = FALSE, ...)
                      
                      errs[l] <- forest$prediction.error
                      
                    }
                    
                    # Optimized vector of c values:
                    cvalues <- cvaluesall[[which.max.random(-errs)]]
                    
                    return(cvalues)
                    
                  }
                  
                  
                  
                  if(block.method=="RandomBlock") {
                    
                    # Number of blocks:
                    M <- length(blocks)
                    
                    # Simulate 'nsets' vectors of c values with the ordering
                    # given by morder,  for each of these construct a forest,
                    # and calculate the corresponding OOB error.
                    # Then use that vector of c values out of the ones generated
                    # for which the corresponding forest featured the smallest
                    # OOB error.
                    
                    errs <- 0
                    cvaluesall <- list()
                    
                    for(l in 1:nsets) {
                      
                      cvalues <- diff(c(0, sort(runif(M-1)), 1))
                      
                      if (always.select.block > 0) {
                        cvalues[always.select.block] <- 0
                      }
                      
                      cvaluesall[[l]] <- cvalues  
                      
                      forest <- blockForest(dependent.variable.name = "time", status.variable.name = "status", 
                                            data = data, num.trees = num.trees.pre,
                                            blocks = blocks,
                                            block.weights = cvalues,
                                            mtry = mtry, keep.inbag = TRUE, block.method=block.method, 
                                            splitrule = splitrule, write.forest = FALSE, ...)
                      
                      errs[l] <- forest$prediction.error
                      
                    }
                    
                    # Optimized vector of c values:
                    cvalues <- cvaluesall[[which.max.random(-errs)]]
                    
                    return(cvalues)
                    
                  }
                  
                })
              
  )
