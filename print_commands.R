phantom <- "~/decktape-1.0.0/phantomjs "
decktape <- "~/decktape-1.0.0/decktape.js "
working_dir <- "~/Dropbox/Work/epi501_ta/epi501_review/"

## Print PDF of intro slides
system(paste0(phantom, decktape, 
              working_dir, "jan27-intro-to-odes/index.html ", 
              working_dir, "jan27-intro-to-odes/jan27-intro-to-r.pdf"))

## Print PDF of measles
system(paste0(phantom, decktape, 
              working_dir, "jan30-timesteps-measles-seir/index.html ", 
              working_dir, "jan30-timesteps-measles-seir/measles-handout.pdf"))

## Print PDF of ebola
system(paste0(phantom, decktape, 
              working_dir, "feb-1-ebola/index.html ", 
              working_dir, "feb-1-ebola/ebola-handout.pdf"))
