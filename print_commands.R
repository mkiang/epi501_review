## Print PDF of intro slides
system(paste0("~/decktape-1.0.0/phantomjs ", 
              "~/decktape-1.0.0/decktape.js ", 
              "~/Dropbox/Work/epi501_ta/epi501_review/", 
              "jan27-intro-to-odes/index.html ", 
              "~/Dropbox/Work/epi501_ta/epi501_review/", 
              "jan27-intro-to-odes/jan27-intro-to-r.pdf"))

## Print PDF of measles
system(paste0("~/decktape-1.0.0/phantomjs ", 
              "~/decktape-1.0.0/decktape.js ", 
              "~/Dropbox/Work/epi501_ta/epi501_review/", 
              "jan30-timesteps-measles-seir/index.html ", 
              "~/Dropbox/Work/epi501_ta/epi501_review/", 
              "jan30-timesteps-measles-seir/measles-handout.pdf"))
