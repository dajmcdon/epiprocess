% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{archive_cases_dv_subset}
\alias{archive_cases_dv_subset}
\title{Subset of daily doctor visits and cases from California, Florida, Texas, and New York in archive format}
\format{
An \code{epi_archive} data format. The data table DT has 129,638 rows and 5 columns:
\describe{
\item{geo_value}{the geographic value associated with each row of measurements.}
\item{time_value}{the time value associated with each row of measurements.}
\item{version}{the time value specifying the version for each row of measurements. }
\item{percent_cli}{percentage of doctor’s visits with CLI (COVID-like illness) computed from medical insurance claims}
\item{case_rate_7d_av}{7-day average signal of number of new confirmed deaths due to COVID-19 per 100,000 population, daily}
}
}
\source{
This object contains a modified part of the \href{https://github.com/CSSEGISandData/COVID-19}{COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University} as \href{https://cmu-delphi.github.io/delphi-epidata/api/covidcast-signals/jhu-csse.html}{republished in the COVIDcast Epidata API}. This data set is licensed under the terms of the
\href{https://creativecommons.org/licenses/by/4.0/}{Creative Commons Attribution 4.0 International license}
by Johns Hopkins University on behalf of its Center for Systems Science in Engineering.
Copyright Johns Hopkins University 2020.

Modifications:
\itemize{
\item \href{https://cmu-delphi.github.io/delphi-epidata/api/covidcast-signals/doctor-visits.html}{From the COVIDcast Epidata Doctor Visits API}: These signals are taken directly from the JHU CSSE \href{https://github.com/CSSEGISandData/COVID-19}{COVID-19 GitHub repository} without changes. The 7-day average signals are computed by Delphi by calculating moving averages of the preceding 7 days, so the signal for June 7 is the average of the underlying data for June 1 through 7, inclusive.
\item Furthermore, the data has been limited to a very small number of rows, the signal names slightly altered, and formatted into a tibble.
}
}
\usage{
archive_cases_dv_subset
}
\description{
This data source is based on information about outpatient visits,
provided to us by health system partners, and also contains confirmed
COVID-19 cases based on reports made available by the Center for
Systems Science and Engineering at Johns Hopkins University.
This example data ranges from June 1, 2020 to Dec 1, 2021, and is also limited to California, Florida, Texas, and New York.
}
\keyword{datasets}
