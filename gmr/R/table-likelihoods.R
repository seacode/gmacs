#' Create a table of likelihoods
#'
#' @param M list object(s) created by read_admb function
#' @return dataframe of likelihood components
#' @author D'Arcy N. Webber
#' @export
#' 
table_likelihoods <- function(M)
{
    like_names <- c("catch","cpue","size_comp","rec_dev","growth_inc")
    n <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        df <- data.frame(Model = names(M)[i], component = like_names, A$nloglike)
        df <- melt(df)
        mdf <- rbind(mdf, df)
    }
    mdf$variable <- gsub("V", "", mdf$variable)
    names(mdf) <- c("Model", "Component", "Fishery", "nloglike")
    return(mdf)
}


#' Create a table of penalties
#'
#' Nees to be fixed if Jim changes order
#'
#' @param M list object(s) created by read_admb function
#' @return dataframe of likelihood components for each model in M
#' @author D'Arcy N. Webber
#' @export
#' 
table_penalties <- function(M)
{
    pen_names <- c("log_fdev","mean_F","M_walk","rec_dev1","rec_dev2","rec_dev3")
    n <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A <- M[[i]]
        df <- data.frame(Model = names(M)[i], component = pen_names, nlogPenalty = A$nlogPenalty)
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Create a table of priors
#'
#' @param M list object(s) created by read_admb function
#' @return dataframe of prior components
#' @author D'Arcy N. Webber
#' @export
#' 
table_priors <- function(M)
{
    #prior_names <- c("log_fdev","mean_F","M_walk","rec_dev1","rec_dev2","rec_dev3")
    n <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A <- M[[i]]
        A$priorDensity
        df <- data.frame(Model = names(M)[i], t(round(A$priorDensity, 3)), Total = round(sum(A$priorDensity), 3))
        df <- melt(df)
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}
