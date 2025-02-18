% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/methods-epi_archive.R
\name{epix_slide}
\alias{epix_slide}
\title{Slide a function over variables in an \code{epi_archive} object}
\usage{
epix_slide(
  x,
  f,
  ...,
  n = 7,
  group_by,
  ref_time_values,
  time_step,
  new_col_name = "slide_value",
  as_list_col = FALSE,
  names_sep = "_",
  all_rows = FALSE
)
}
\arguments{
\item{x}{An \code{epi_archive} object.}

\item{f}{Function or formula to slide over variables in \code{x}. To "slide" means
to apply a function or formula over a running window of \code{n} time steps
(where one time step is typically one day or one week). If a function, \code{f}
must take \code{x}, a data frame with the same column names as the original
object; followed by any number of named arguments; and ending with
\code{...}. If a formula, \code{f} can operate directly on columns accessed via
\code{.x$var}, as in \code{~ mean(.x$var)} to compute a mean of a column \code{var} over a
sliding window of \code{n} time steps.}

\item{...}{Additional arguments to pass to the function or formula specified
via \code{f}. Alternatively, if \code{f} is missing, then the current argument is
interpreted as an expression for tidy evaluation.}

\item{n}{Number of time steps to use in the running window. For example, if
\code{n = 7}, and one time step is one day, then to produce a value on January 7
we apply the given function or formula to data in between January 1 and
7. Default is 7.}

\item{group_by}{The variable(s) to group by before slide computation. If
missing, then the keys in the underlying data table, excluding \code{time_value}
and \code{version}, will be used for grouping. To omit a grouping entirely, use
\code{group_by = NULL}.}

\item{ref_time_values}{Time values for sliding computations, meaning, each
element of this vector serves as the reference time point for one sliding
window. If missing, then this will be set to all unique time values in the
underlying data table, by default.}

\item{time_step}{Optional function used to define the meaning of one time
step, which if specified, overrides the default choice based on the
\code{time_value} column. This function must take a positive integer and return
an object of class \code{lubridate::period}. For example, we can use \code{time_step = lubridate::hours} in order to set the time step to be one hour (this
would only be meaningful if \code{time_value} is of class \code{POSIXct}).}

\item{new_col_name}{String indicating the name of the new column that will
contain the derivative values. Default is "slide_value"; note that setting
\code{new_col_name} equal to an existing column name will overwrite this column.}

\item{as_list_col}{Should the new column be stored as a list column? Default
is \code{FALSE}, in which case a list object returned by \code{f} would be unnested
(using \code{tidyr::unnest()}), and the names of the resulting columns are given
by prepending \code{new_col_name} to the names of the list elements.}

\item{names_sep}{String specifying the separator to use in \code{tidyr::unnest()}
when \code{as_list_col = FALSE}. Default is "_". Using \code{NULL} drops the prefix
from \code{new_col_name} entirely.}

\item{all_rows}{If \code{all_rows = TRUE}, then the output will have one row per
combination of grouping variables and unique time values in the underlying
data table. Otherwise, there will be one row in the output for each time
value in \code{x} that acts as a reference time value. Default is \code{FALSE}.}
}
\value{
A tibble whose columns are: the grouping variables, \code{time_value},
containing the reference time values for the slide computation, and a
column named according to the \code{new_col_name} argument, containing the slide
values.
}
\description{
Slides a given function over variables in an \code{epi_archive} object. This
behaves similarly to \code{epi_slide()}, with the key exception that it is
version-aware: the sliding computation at any given reference time t is
performed on \strong{data that would have been available as of t}. See the
\href{https://cmu-delphi.github.io/epiprocess/articles/archive.html}{archive vignette} for
examples.
}
\details{
Two key distinctions between inputs to the current function and
\code{epi_slide()}:
\enumerate{
\item \code{epix_slide()} uses windows that are \strong{always right-aligned} (in
\code{epi_slide()}, custom alignments could be specified using the \code{align} or
\code{before} arguments).
\item \code{epix_slide()} uses a \code{group_by} to specify the grouping upfront (in
\code{epi_slide()}, this would be accomplished by a preceding function call to
\code{dplyr::group_by()}).
Apart from this, the interfaces between \code{epix_slide()} and \code{epi_slide()} are
the same.
}

Note that the outputs are a similar but different: \code{epix_slide()} only
returns the grouping variables, \code{time_value}, and the new columns from
sliding, whereas \code{epi_slide()} returns all original variables plus the new
columns from sliding.

Furthermore, the current function can be considerably slower than
\code{epi_slide()}, for two reasons: (1) it must repeatedly fetch
properly-versioned snapshots from the data archive (via its \code{as_of()}
method), and (2) it performs a "manual" sliding of sorts, and does not
benefit from the highly efficient \code{slider} package. For this reason, it
should never be used in place of \code{epi_slide()}, and only used when
version-aware sliding is necessary (as it its purpose).

Finally, this is simply a wrapper around the \code{slide()} method of the
\code{epi_archive} class, so if \code{x} is an \code{epi_archive} object, then:\preformatted{epix_slide(x, new_var = comp(old_var), n = 120)
}

is equivalent to:\preformatted{x$slide(x, new_var = comp(old_var), n = 120)
}
}
\examples{
# these dates are reference time points for the 3 day average sliding window
# The resulting epi_archive ends up including data averaged from:
# 0 day which has no results, for 2020-06-01
# 1 day, for 2020-06-02
# 2 days, for the rest of the results
# never 3 days dur to data latency

time_values <- seq(as.Date("2020-06-01"),
                      as.Date("2020-06-15"),
                      by = "1 day")
epix_slide(x = archive_cases_dv_subset,
           f = ~ mean(.x$case_rate),
           n = 3,
           group_by = geo_value,
           ref_time_values = time_values,
           new_col_name = 'case_rate_3d_av')
}
