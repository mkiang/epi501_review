phantom <- "~/decktape-1.0.0/phantomjs "
decktape <- "~/decktape-1.0.0/decktape.js "
working_dir <- "~/Dropbox/epi501_review/"

## Print PDF of intro to ODEs
system(paste0(phantom, decktape, 
              working_dir, "20180129_intro_odes/index.html ", 
              working_dir, "20180129_intro_odes/20180129-intro-odes.pdf"))

## Print Ebola slides
system(paste0(phantom, decktape, 
              working_dir, "20180202_ebola/index.html ", 
              working_dir, "20180202_ebola/20180202-ebola.pdf"))

## Print Final slides
system(paste0(phantom, decktape, 
              working_dir, "20180302_review_session/index.html ", 
              working_dir, "20180302_review_session/review_slides.pdf"))
