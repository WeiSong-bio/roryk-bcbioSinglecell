#' Plot Feature
#'
#' @name plotFeature
#' @family Clustering Functions
#' @author Michael Steinbaugh
#'
#' @inheritParams plotTSNE
#' @inheritParams general
#' @param features Character vector of features (e.g. gene expression, PC
#'   scores, number of genes detected).
#' @param legend Show legends in paneled plots. Defaults to `FALSE` because
#'   typically these look too busy and the legends can get cut off.
#'
#' @seealso [Seurat::FeaturePlot()].
#'
#' @return `ggplot` or `list`.
#'
#' @examples
#' # seurat ====
#' object <- Seurat::pbmc_small
#' features <- c("nUMI", "nGene", "PC1", "PC2")
#'
#' # Plot grid
#' plotFeatureTSNE(object, features = features)
#' plotFeatureUMAP(object, features = features)
#'
#' # Markdown
#' plotFeature(object, features = features, dimRed = "tsne")
NULL



# Constructors =================================================================
.plotFeatureDimRed <- function(
    object,
    features,
    dimRed = c("tsne", "umap"),
    color = "auto",
    pointSize = 0.5,
    pointAlpha = 0.8,
    label = TRUE,
    labelSize = 6L,
    dark = TRUE,
    grid = TRUE,
    legend = FALSE,
    aspectRatio = 1L
) {
    assert_is_character(features)
    dimRed <- match.arg(dimRed)

    if (isTRUE(dark)) {
        fill <- "black"
    } else {
        fill <- "white"
    }

    if (dimRed == "tsne") {
        fetchDimRedData <- fetchTSNEData
        dimCols <- c("tSNE1", "tSNE2")
    } else if (dimRed == "umap") {
        fetchDimRedData <- fetchUMAPData
        dimCols <- c("umap1", "umap2")
    }
    dimRedData <- fetchDimRedData(object)

    featureData <- FetchData(object, vars.all = features)

    # Columns from `FetchData` take priority, if there is overlap
    if (length(intersect(colnames(dimRedData), colnames(featureData)))) {
        dimRedData <- dimRedData %>%
            .[, setdiff(colnames(.), colnames(featureData))]
    }
    assert_are_identical(rownames(dimRedData), rownames(featureData))
    assert_are_disjoint_sets(colnames(dimRedData), colnames(featureData))
    data <- cbind(dimRedData, featureData)

    plotlist <- lapply(features, function(feature) {
        p <- ggplot(
            data = data,
            mapping = aes_string(
                x = dimCols[[1L]],
                y = dimCols[[2L]],
                color = feature
            )
        ) +
            geom_point(
                alpha = pointAlpha,
                size = pointSize
            ) +
            labs(title = feature)

        if (isTRUE(label)) {
            if (isTRUE(dark)) {
                labelColor <- "white"
            } else {
                labelColor <- "black"
            }
            p <- p +
                geom_text(
                    mapping = aes_string(
                        x = "centerX",
                        y = "centerY",
                        label = "ident"
                    ),
                    color = labelColor,
                    size = labelSize,
                    fontface = "bold"
                )
        }

        if (isTRUE(dark)) {
            p <- p +
                theme_midnight(
                    aspect_ratio = aspectRatio,
                    grid = grid
                )
            if (color == "auto") {
                color <- scale_color_viridis(
                    option = "plasma",
                    discrete = FALSE
                )
            }
        } else {
            p <- p +
                theme_paperwhite(
                    aspect_ratio = aspectRatio,
                    grid = grid
                )
            if (color == "auto") {
                color <- scale_color_gradient(
                    low = "gray90",
                    high = "black"
                )
            }
        }

        if (is(color, "ScaleContinuous")) {
            p <- p + color
        }

        if (!isTRUE(legend)) {
            p <- p + guides(color = "none")
        }

        p
    })

    # Return ===================================================================
    plot_grid(plotlist = plotlist) +
        theme(
            plot.background = element_rect(
                color = NA,
                fill = fill
            )
        )
}



# Methods ======================================================================
#' @rdname plotFeature
#' @export
setMethod(
    "plotFeature",
    signature("seurat"),
    function(
        object,
        features,
        dimRed = c("tsne", "umap"),
        dark = TRUE,
        grid = TRUE,
        headerLevel = 2L
    ) {
        assert_is_character(features)
        dimRed <- match.arg(dimRed)
        assert_is_a_bool(dark)
        assert_is_a_bool(grid)
        assertIsAHeaderLevel(headerLevel)
        list <- lapply(features, function(feature) {
            p <- .plotFeatureDimRed(
                object = object,
                features = feature,
                dimRed = dimRed,
                dark = dark,
                grid = grid
            )
            markdownHeader(feature, level = headerLevel, asis = TRUE)
            show(p)
            invisible(p)
        })
        names(list) <- features
        invisible(list)
    }
)



#' @rdname plotFeature
#' @export
setMethod(
    "plotFeatureTSNE",
    signature("seurat"),
    function(
        object,
        features,
        color = "auto",
        pointSize = 0.5,
        pointAlpha = 0.8,
        label = TRUE,
        labelSize = 6L,
        dark = TRUE,
        grid = TRUE,
        legend = FALSE,
        aspectRatio = 1L
    ) {
        .plotFeatureDimRed(
            object = object,
            features = features,
            dimRed = "tsne",
            color = color,
            pointSize = pointSize,
            pointAlpha = pointAlpha,
            label = label,
            labelSize = labelSize,
            dark = dark,
            grid = grid,
            legend = legend,
            aspectRatio = aspectRatio
        )
    }
)



#' @rdname plotFeature
#' @export
setMethod(
    "plotFeatureUMAP",
    signature("seurat"),
    function(
        object,
        features,
        color = "auto",
        pointSize = 0.5,
        pointAlpha = 0.8,
        label = TRUE,
        labelSize = 6L,
        dark = TRUE,
        grid = TRUE,
        legend = FALSE,
        aspectRatio = 1L
    ) {
        .plotFeatureDimRed(
            object = object,
            features = features,
            dimRed = "umap",
            color = color,
            pointSize = pointSize,
            pointAlpha = pointAlpha,
            label = label,
            labelSize = labelSize,
            dark = dark,
            grid = grid,
            legend = legend,
            aspectRatio = aspectRatio
        )
    }
)