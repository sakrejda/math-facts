
#' Create a pair of integers up to a max value.
integer_pairs <- function(max) expand 

#' Create a question 
setRefClass(Class='math_question',
  fields = list(
    pair = 'numeric',
    times = 'POSIXct',
    operator__ = 'function',
    max__ = 'numeric',
    op_name__ = 'character',
    answer__ = 'numeric',
    table__ = 'data.frame',
    next__ = 'numeric'
  ),
  methods = list(
    initialize = function(operator, max) {
      times <<- rep(now(),2)
      pair <<- rep(0,2)
      operator__ <<- operator
      op_name__ <<- deparse(substitute(operator))
      max__ <<- max
      full_table()
      next__ <<- 1
    },
    full_table = function() {
      table__ <<- expand.grid(a=1:max__, b=1:max__) %>%
        arrange(sample.int(n=max__*max__, size=max__*max__)) %>% 
        data.frame %>% mutate(done=FALSE, timing=Inf, answer=a*b) %>%
        mutate(pair = paste(a, op_name__, b))
    },
    get_table = function() {
      table <- table__ %>% filter(!done & a<=max & b<=max)
      return(table)
    },
    adjust_max = function(max) {
      if (max > max__) {
        old_table <- table__
        full_table()
        table__ <<- table__ %>% filter(a > 
      } 
      if (max < max__) {

      } 
    },
    prompt = function() {
      pair <<- as.numeric(get_table()[next__,c('a','b')])
      o <- paste0(
        "What is ", pair[1], " ", op_name__, " ",
        pair[2], "?"
      )
      answer__ <<- operator__(pair[1], pair[2])
      times[1] <<- now()
      return(o)
    },
    update_next = function() { 
      table__ <<- table__ %>% arrange(sample.int(n=max__*max__, size=max__*max__))
      next__ <<- min(which(table__[,'done'] != TRUE))
      if (length(next__) == 0) {
        table__ <<- mutate(table__, done=FALSE) 
        next__ <<- 1
      }
    },
    check = function(answer) {
      times[2] <<- now()
      timing <- as.numeric(difftime(times[2],times[1], units='secs'))
      correct <- answer == answer__
      if (length(correct) != 0 && isTRUE(correct)) {
        table__[next__,'done'] <<- TRUE
        table__[next__,'timing'] <<- timing
        return(list(time = timing, correct = correct))
      } else 
        return(list(correct=correct))
    }
  )
)







