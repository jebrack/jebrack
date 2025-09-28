# scripts/update-chapters.R

# This script automatically updates the list of chapters in _quarto.yml
# to include all .qmd files from the 'entries/' directory.
# It runs automatically before the book is rendered.

library(yaml)

# --- Configuration ---
quarto_yaml_path <- "_quarto.yml"
entries_dir <- "entries"
# --- End Configuration ---

# Read the existing _quarto.yml file
quarto_config <- read_yaml(quarto_yaml_path)

# Find all .qmd files in the entries directory, sorted alphabetically
entry_files <- list.files(
  path = entries_dir,
  pattern = "\\.qmd$",
  full.names = TRUE
)
entry_files <- sort(entry_files)

# Preserve any existing chapters that are not in the entries/ directory (like index.qmd)
existing_chapters <- quarto_config$book$chapters
other_chapters <- existing_chapters[!grepl(paste0("^", entries_dir), existing_chapters)]

# Combine the non-entry chapters with the newly found entry files
# This handles additions, deletions, and renames automatically.
new_chapters <- c(other_chapters, entry_files)

# Update the configuration object
quarto_config$book$chapters <- new_chapters

# Write the updated configuration back to the _quarto.yml file
write_yaml(quarto_config,
           quarto_yaml_path,
           handlers = list(
             logical = function(x) {
               result <- ifelse(x, "true", "false")
               class(result) <- "verbatim"
               return(result)
             }
           ))

cat("Successfully synchronized chapters in _quarto.yml.\n")
