% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/methods-plotUMIsPerCell.R
\docType{methods}
\name{plotUMIsPerCell}
\alias{plotUMIsPerCell}
\alias{plotUMIsPerCell}
\alias{plotUMIsPerCell,SingleCellExperiment-method}
\alias{plotUMIsPerCell,seurat-method}
\title{Plot UMIs per Cell}
\usage{
plotUMIsPerCell(object, ...)

\S4method{plotUMIsPerCell}{SingleCellExperiment}(object, geom = c("ecdf",
  "ridgeline", "violin", "histogram", "boxplot"), interestingGroups, min = 0L,
  max = Inf, point = c("none", "inflection", "knee"), trans = "log10",
  color = NULL, fill = NULL, title = "UMIs per cell")

\S4method{plotUMIsPerCell}{seurat}(object, geom = c("ecdf", "ridgeline",
  "violin", "histogram", "boxplot"), interestingGroups, min = 0L, max = Inf,
  point = c("none", "inflection", "knee"), trans = "log10", color = NULL,
  fill = NULL, title = "UMIs per cell")
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}

\item{geom}{Plot type. Uses \code{\link[=match.arg]{match.arg()}} and defaults to the first argument
in the vector.}

\item{interestingGroups}{Character vector of interesting groups. Must be
formatted in camel case and intersect with \code{\link[=sampleData]{sampleData()}} colnames.}

\item{min}{Recommended minimum value cutoff.}

\item{max}{Recommended maximum value cutoff.}

\item{point}{Label either the "\code{knee}" or "\code{inflection}" points per sample.
To disable, use "\code{none}". Requires \code{geom = "ecdf"}.}

\item{trans}{Name of the axis scale transformation to apply. See
\code{help("scale_x_continuous", "ggplot2")} for more information.}

\item{color}{Desired ggplot color scale. Must supply discrete values. When
set to \code{NULL}, the default ggplot2 color palette will be used. If manual
color definitions are desired, we recommend using
\code{\link[ggplot2:scale_color_manual]{ggplot2::scale_color_manual()}}.}

\item{fill}{Desired ggplot fill scale. Must supply discrete values. When set
to \code{NULL}, the default ggplot2 color palette will be used. If manual color
definitions are desired, we recommend using \code{\link[ggplot2:scale_fill_manual]{ggplot2::scale_fill_manual()}}.}

\item{title}{Plot title.}
}
\value{
\code{ggplot}.
}
\description{
Plot the universal molecular identifiers (UMIs) per cell.
}
\examples{
# SingleCellExperiment ====
plotUMIsPerCell(cellranger_small, geom = "ecdf")
plotUMIsPerCell(cellranger_small, geom = "histogram")
plotUMIsPerCell(cellranger_small, geom = "ridgeline")
plotUMIsPerCell(cellranger_small, geom = "violin")
plotUMIsPerCell(cellranger_small, geom = "boxplot")
}
\seealso{
Other Quality Control Functions: \code{\link{barcodeRanksPerSample}},
  \code{\link{filterCells}}, \code{\link{metrics}},
  \code{\link{plotCellCounts}},
  \code{\link{plotGenesPerCell}},
  \code{\link{plotMitoRatio}},
  \code{\link{plotMitoVsCoding}},
  \code{\link{plotNovelty}}, \code{\link{plotQC}},
  \code{\link{plotReadsPerCell}},
  \code{\link{plotZerosVsDepth}}
}
\author{
Michael Steinbaugh, Rory Kirchner
}
