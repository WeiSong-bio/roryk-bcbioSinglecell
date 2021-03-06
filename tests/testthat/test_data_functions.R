context("Data Functions")



# aggregateReplicates ==========================================================
test_that("aggregateReplicates", {
    x <- aggregateReplicates(indrops_small)
    expect_s4_class(x, "SingleCellExperiment")
    expect_identical(
        dim(x),
        c(500L, 500L)
    )
    map <- metadata(x)[["aggregateReplicates"]]
    expect_is(map, "factor")
    expect_identical(length(map), 500L)
    expect_identical(length(levels(map)), 500L)
})



# fetchPCAData =================================================================
test_that("fetchPCAData", {
    x <- fetchPCAData(seurat_small)
    expect_is(x, "data.frame")
    expect_identical(
        lapply(x, class),
        list(
            sampleID = "factor",
            nGene = "integer",
            nUMI = "integer",
            nCoding = "integer",
            nMito = "integer",
            log10GenesPerUMI = "numeric",
            mitoRatio = "numeric",
            orig.ident = "factor",
            res.0.4 = "character",
            res.0.8 = "character",
            res.1.2 = "character",
            ident = "factor",
            sampleName = "factor",
            description = "factor",
            index = "factor",
            interestingGroups = "factor",
            PC1 = "numeric",
            PC2 = "numeric",
            centerX = "numeric",
            centerY = "numeric"
        )
    )
})



# fetchTSNEData ================================================================
test_that("fetchTSNEData", {
    x <- fetchTSNEData(seurat_small)
    expect_is(x, "data.frame")
    expect_identical(
        lapply(x, class),
        list(
            sampleID = "factor",
            nGene = "integer",
            nUMI = "integer",
            nCoding = "integer",
            nMito = "integer",
            log10GenesPerUMI = "numeric",
            mitoRatio = "numeric",
            orig.ident = "factor",
            res.0.4 = "character",
            res.0.8 = "character",
            res.1.2 = "character",
            ident = "factor",
            sampleName = "factor",
            description = "factor",
            index = "factor",
            interestingGroups = "factor",
            tSNE_1 = "numeric",
            tSNE_2 = "numeric",
            centerX = "numeric",
            centerY = "numeric"
        )
    )
})



# fetchTSNEExpressionData ======================================================
test_that("fetchTSNEExpressionData", {
    x <- fetchTSNEExpressionData(
        object = seurat_small,
        genes = head(rownames(seurat_small))
    )
    expect_is(x, "data.frame")
    expect_identical(
        lapply(x, class),
        list(
            sampleID = "factor",
            nGene = "integer",
            nUMI = "integer",
            nCoding = "integer",
            nMito = "integer",
            log10GenesPerUMI = "numeric",
            mitoRatio = "numeric",
            orig.ident = "factor",
            res.0.4 = "character",
            res.0.8 = "character",
            res.1.2 = "character",
            ident = "factor",
            sampleName = "factor",
            description = "factor",
            index = "factor",
            interestingGroups = "factor",
            tSNE_1 = "numeric",
            tSNE_2 = "numeric",
            centerX = "numeric",
            centerY = "numeric",
            mean = "numeric",
            median = "numeric",
            sum = "numeric"
        )
    )
})



# gene2symbol ==================================================================
colnames <- c("geneID", "geneName")

test_that("gene2symbol : bcbioSingleCell", {
    x <- gene2symbol(indrops_small)
    expect_is(x, "data.frame")
    expect_identical(colnames(x), colnames)
})

test_that("gene2symbol : seurat", {
    x <- gene2symbol(seurat_small)
    expect_is(x, "data.frame")
    expect_identical(colnames(x), colnames)
})




# interestingGroups ============================================================
test_that("interestingGroups : bcbioSingleCell", {
    expect_identical(
        interestingGroups(indrops_small),
        "sampleName"
    )
})

test_that("interestingGroups<- : bcbioSingleCell", {
    error <- "The interesting groups \"XXX\" are not defined"
    expect_error(
        interestingGroups(indrops_small) <- "XXX",
        error
    )
    expect_error(
        interestingGroups(seurat_small) <- "XXX",
        error
    )
})

test_that("interestingGroups : seurat", {
    expect_identical(
        interestingGroups(seurat_small),
        "sampleName"
    )
    expect_identical(
        interestingGroups(seurat_small),
        "sampleName"
    )
})

test_that("interestingGroups<- : seurat", {
    interestingGroups(indrops_small) <- "sampleName"
    expect_identical(
        interestingGroups(indrops_small),
        "sampleName"
    )
    interestingGroups(seurat_small) <- "sampleName"
    expect_identical(
        interestingGroups(seurat_small),
        "sampleName"
    )
    x <- Seurat::pbmc_small
    expect_error(interestingGroups(Seurat::pbmc_small) <- "sampleName")
})



# metrics ======================================================================
test_that("metrics : seurat", {
    # Check that metrics accessor data matches meta.data slot
    x <- metrics(seurat_small)
    y <- seurat_small@meta.data
    x <- x[, colnames(y)]
    expect_identical(x, y)
})



# sampleData ===================================================================
all <- list(
    "sampleName"  = "factor",
    "fileName"  = "factor",
    "description"  = "factor",
    "index" = "factor",
    "sequence" = "factor",
    "aggregate" = "factor",
    "revcomp" = "factor",
    "interestingGroups" = "factor"
)

clean <- DataFrame(
    "sampleName" = factor("rep_1"),
    row.names = factor("multiplexed_AAAAAAAA")
)

test_that("sampleData : bcbioSingleCell", {
    # Return all columns
    x <- sampleData(indrops_small, clean = FALSE)
    expect_identical(lapply(x, class), all)

    # Clean mode (factor columns only)
    x <- sampleData(indrops_small, clean = TRUE)
    expect_identical(x, clean)
})

test_that("sampleData : seurat", {
    # Return all columns
    x <- sampleData(seurat_small, clean = FALSE)
    expect_identical(
        lapply(x, class),
        list(
            sampleName = "factor",
            description = "factor",
            index = "factor",
            interestingGroups = "factor"
        )
    )

    # Clean mode (factor columns only)
    x <- sampleData(seurat_small, clean = TRUE)
    expect_identical(
        lapply(x, class),
        list(
            sampleName = "factor"
        )
    )

    # Return NULL for other seurat objects
    expect_identical(sampleData(Seurat::pbmc_small), NULL)
})



# selectSamples ================================================================
test_that("selectSamples : bcbioSingleCell", {
    x <- selectSamples(indrops_small, sampleName = "rep_1")
    expect_s4_class(x, "bcbioSingleCell")
    expect_true(metadata(x)[["selectSamples"]])
    expect_identical(dim(x), c(500L, 500L))
    expect_identical(
        rownames(sampleData(x)),
        "multiplexed_AAAAAAAA"
    )
})

test_that("selectSamples : Match failure", {
    expect_error(
        selectSamples(indrops_small, sampleName = "XXX"),
        "\"sampleName\" metadata column doesn't contain XXX"
    )
})



# subsetPerSample ==============================================================
test_that("subsetPerSample : bcbioSingleCell", {
    x <- subsetPerSample(indrops_small, assignAndSave = FALSE)
    expect_is(x, "list")
    expect_identical(names(x), "multiplexed_AAAAAAAA")
    subsetPerSample(
        object = indrops_small,
        assignAndSave = TRUE,
        dir = "subsetPerSample"
    )
    expect_identical(
        list.files("subsetPerSample"),
        "multiplexed_AAAAAAAA.rda"
    )
    load("subsetPerSample/multiplexed_AAAAAAAA.rda")
    expect_identical(
        dim(multiplexed_AAAAAAAA),
        c(500L, 500L)
    )
    unlink("subsetPerSample", recursive = TRUE)
})



# topBarcodes ==================================================================
test_that("topBarcodes : SingleCellExperiment", {
    # data.frame
    x <- topBarcodes(cellranger_small, return = "data.frame")
    expect_identical(dplyr::group_vars(x), "sampleID")
    expect_identical(
        lapply(x, class),
        list(
            sampleID = "factor",
            sampleName = "factor",
            nUMI = "integer",
            cellID = "character"
        )
    )

    # list
    x <- topBarcodes(cellranger_small, return = "list")
    expect_is(x, "list")
})
