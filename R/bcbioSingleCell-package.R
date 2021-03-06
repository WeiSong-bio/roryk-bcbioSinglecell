#' bcbioSingleCell
#'
#' Import and analyze [bcbio](http://bcbio-nextgen.readthedocs.io) single-cell
#' RNA-seq data.
#'
#' @name bcbioSingleCell-package
#' @docType package
#'
#' @importClassesFrom Seurat seurat
#' @importClassesFrom SingleCellExperiment SingleCellExperiment
#'
#' @importFrom assertive.base assert_are_identical
#' @importFrom assertive.files assert_all_are_dirs assert_all_are_existing_files
#' @importFrom assertive.numbers assert_all_are_greater_than_or_equal_to
#'   assert_all_are_in_left_open_range assert_all_are_in_range
#'   assert_all_are_in_right_open_range assert_all_are_non_negative
#'   assert_all_are_positive
#' @importFrom assertive.properties assert_are_same_length assert_has_dimnames
#'   assert_has_names assert_has_no_duplicates assert_has_rows
#'   assert_is_non_empty assert_is_of_length has_dims has_names
#' @importFrom assertive.sets assert_are_disjoint_sets
#'   assert_are_intersecting_sets assert_are_set_equal assert_is_subset
#' @importFrom assertive.strings assert_all_are_matching_regex
#'   assert_all_are_non_missing_nor_empty_character
#'   assert_any_are_matching_regex
#' @importFrom assertive.types assert_is_a_bool assert_is_a_number
#'   assert_is_a_string assert_is_all_of assert_is_an_integer assert_is_any_of
#'   assert_is_character assert_is_data.frame assert_is_environment
#'   assert_is_factor assert_is_function assert_is_integer assert_is_list
#'   assert_is_matrix assert_is_numeric assert_is_tbl_df is_a_string
#'   is_character
#' @importFrom basejump assertHasRownames assertIsAHeaderLevel
#'   assertIsAStringOrNULL assertIsAnImplicitInteger
#'   assertIsAnImplicitIntegerOrNULL assertIsANumberOrNULL
#'   assertIsColorScaleContinuousOrNULL assertIsColorScaleDiscreteOrNULL
#'   assertIsFillScaleDiscreteOrNULL assertIsGene2symbol assertIsTx2gene
#'   assignAndSaveData camel convertGenesToSymbols convertUCSCBuildToEnsembl
#'   detectOrganism emptyRanges hasRownames initializeDirectory
#'   makeGRangesFromEnsembl makeGRangesFromGFF makeNames makeTx2geneFromGFF
#'   markdownHeader markdownPlotlist printString readFileByExtension readYAML
#'   stripTranscriptVersions theme_midnight theme_paperwhite tx2geneFromGFF
#' @importFrom bcbioBase assertFormalInterestingGroups bcbio_geom_abline
#'   bcbio_geom_label bcbio_geom_label_average bcbio_geom_label_repel flatFiles
#'   minimalSampleData prepareSummarizedExperiment readDataVersions readLog
#'   readProgramVersions readSampleData readTx2gene readYAMLSampleData
#'   sanitizeSampleData sampleDirs uniteInterestingGroups
#' @importFrom Biobase rowMedians sampleNames
#' @importFrom cowplot draw_plot ggdraw plot_grid
#' @importFrom dplyr arrange bind_rows desc everything filter group_by
#'   group_vars left_join matches mutate mutate_all mutate_at mutate_if n rename
#'   select select_if slice summarize summarize_all ungroup
#' @importFrom GenomicFeatures genes makeTxDbFromGFF transcripts
#' @importFrom ggplot2 aes_ aes_string coord_flip element_blank element_line
#'   element_rect element_text expand_limits facet_wrap geom_bar geom_boxplot
#'   geom_histogram geom_hline geom_line geom_point geom_smooth
#'   geom_step geom_text geom_violin geom_vline ggtitle guide_colourbar
#'   guide_legend guides labs qplot scale_radius scale_x_continuous
#'   scale_y_continuous stat_ecdf theme xlab xlim ylab
#' @importFrom ggridges geom_density_ridges
#' @importFrom graphics hist
#' @importFrom grid arrow unit
#' @importFrom jsonlite read_json
#' @importFrom knitr kable
#' @importFrom magrittr %>% set_colnames set_names set_rownames
#' @importFrom Matrix colSums readMM rowMeans rowSums
#' @importFrom Matrix.utils aggregate.Matrix
#' @importFrom methods .hasSlot as as<- getMethod is new show slot slot<-
#'   validObject
#' @importFrom parallel mclapply mcmapply
#' @importFrom pbapply pblapply
#' @importFrom purrr map
#' @importFrom readr read_lines read_tsv
#' @importFrom rlang !! !!! sym syms UQ
#' @importFrom S4Vectors DataFrame aggregate as.data.frame as.matrix
#'   complete.cases mcols metadata metadata<- na.omit
#' @importFrom scales percent pretty_breaks
#' @importFrom Seurat as.SingleCellExperiment CreateSeuratObject FetchData
#' @importFrom SingleCellExperiment SingleCellExperiment isSpike isSpike<-
#'   spikeNames
#' @importFrom stats ecdf fitted median model.matrix predict relevel reorder
#'   smooth.spline
#' @importFrom stringr str_extract str_match str_pad str_split
#' @importFrom SummarizedExperiment assay assayNames assays assays<- colData
#'   rowData rowRanges rowRanges<-
#' @importFrom tibble as_tibble column_to_rownames has_rownames remove_rownames
#'   rownames_to_column tibble
#' @importFrom tidyr gather
#' @importFrom utils globalVariables packageVersion
NULL
