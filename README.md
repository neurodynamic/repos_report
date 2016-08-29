![Gem output](https://raw.githubusercontent.com/neurodynamic/repos_report/master/example_output.png)

# Purpose

Prints info on the status of all repos under a given directory.

    $ gem install repos_report

### How it works

To get a report on the status of repos in a directory:
```
rep2 [directory]
```

### A note on speed

This tool is optimized for directories that are populated with just repos and nothing else. I have maybe 100-200 projects in my development directory, and it scans that almost instantly. If it's somewhere with thousands of directories and subdirectories, it's not so snappy. I've found the likeliest culprit for suddenly slower behavior is if I've started a few projects in my dev folder without initializing git repos in them (thus requiring the script to search them and all their subdirectories as well in order to ensure it doesn't miss any repos).