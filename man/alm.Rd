\name{alm}
\alias{alm}
\title{Retrieve PLoS article-level metrics (ALM).}
\usage{
  alm(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL,
    url = "http://alm.plos.org/api/v3/articles",
    info = "totals", months = NULL, days = NULL,
    year = NULL, source = NULL, key = NULL,
    curl = getCurlHandle(), total_details = FALSE,
    sum_metrics = NULL)
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals (character)}

  \item{pmid}{PubMed object identifier (numeric)}

  \item{pmcid}{PubMed Central object identifier (numeric)}

  \item{mdid}{Mendeley object identifier (character)}

  \item{url}{API endpoint, defaults to
  http://alm.plos.org/api/v3/articles (character)}

  \item{info}{One of summary, history, or detail(default
  totals + history in a list).  Not specifying anything
  (the default) returns data.frame of totals across data
  providers. (character)}

  \item{months}{Number of months since publication to
  request historical data for.  See details for a note.
  (numeric)}

  \item{days}{Number of days since publication to request
  historical data for.  See details for a note. (numeric)}

  \item{year}{End of which year to request historical data
  for.  See details for a note. (numeric)}

  \item{source}{Name of source (or list of sources) to get
  ALM information for (character)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile (character)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{total_details}{If FALSE (the default) the standard
  totals data.frame is returned; if TRUE, the totals data
  is in a wide format with more details about the paper,
  including publication date, title, etc. If you set this
  to TRUE, the output should no longer with with
  \code{\link{almplot}}.}

  \item{sum_metrics}{Just like the output you get from
  setting info='totals', you can get summary metrics by day
  (sum_metrics='day'), month (sum_metrics='month'), or year
  (sum_metrics='year').}
}
\value{
  PLoS altmetrics as data.frame's.
}
\description{
  This is the main function to search the PLoS ALM
  (article-level metrics) API. See details for more
  information.
}
\details{
  You can only supply one of the parmeters doi, pmid,
  pmcid, and mdid.

  Query for as many articles at a time as you like. Though
  queries are broken up in to smaller bits of 50
  identifiers at a time.

  If you supply days, months and/or year parameters, days
  takes precedence over months and year.
}
\examples{
\dontrun{
# The default call with either doi, pmid, pmcid, or mdid without specifying
# an argument for info
alm(doi="10.1371/journal.pone.0029797")

# A single DOI
out <- alm(doi='10.1371/journal.pone.0029797', info='detail')
out[["totals"]] # get totals summary data.frame
out[["history"]] # get history summary data.frame

# A single PubMed ID (pmid)
alm(pmid=22590526)

# A single PubMed Central ID (pmcid)
alm(pmcid=212692, info='summary')

# A single Mendeley UUID (mdid)
alm(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7")

# Provide more than one DOI
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
out <- alm(doi=dois)
out[[1]] # get data for the first DOI

# Search for DOI's, then feed into alm
dois <- searchplos(terms='evolution', fields='id', limit = 52)
out <- alm(doi=as.character(dois[,1]))
lapply(out, head)

# Provide more than one pmid
pmids <- c(19300479, 19390606, 19343216)
out <- alm(pmid=pmids)
out[[3]] # get data for the third pmid

# Getting just summary data
alm(doi='10.1371/journal.pone.0039395', info='summary')

# Using days argument
alm(doi='10.1371/journal.pone.0040117', days=30)

# Using the year argument
alm(doi='10.1371/journal.pone.0040117', year=2012)

# Getting data for a specific source
alm(doi='10.1371/journal.pone.0035869', source='mendeley')
alm(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'))
alm(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'), info='history')

# Get detailed totals output
alm(doi='10.1371/journal.pone.0035869', total_details=TRUE)

# Get summary metrics by day
alm(doi='10.1371/journal.pone.0036240', sum_metrics='day')

# Get summary metrics by month
alm(doi='10.1371/journal.pone.0036240', sum_metrics='month')

# Get summary metrics by year
alm(doi='10.1371/journal.pone.0036240', sum_metrics='year')
}
}
\seealso{
  \code{\link{almplot}}
}

