phantom <- "~/decktape-1.0.0/phantomjs "
decktape <- "~/decktape-1.0.0/decktape.js "
working_dir <- "~/Dropbox/epi501_review/"

## Print PDF of intro to ODEs
system(paste0(phantom, decktape, 
              working_dir, "20180129_intro_odes/index.html ", 
              working_dir, "20180129_intro_odes/20180129-intro-odes.pdf"))
