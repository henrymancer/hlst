# Henry's Linux System Tools (HLST)

This is a repo with all the tools, config, and scripts that I have made to improve my Linux experience on new machines.

## Installing the tools
To install, run the following commands:
``` {sh}
$ curl https://github.com/henrymancer/hlst/blob/main/hlstsetup.sh?raw=true -o hlstsetup.sh
$ chmod +x hlstsetup.sh
$ ./hlstsetup.sh
```

For a much shorter method, try the following:
``` {sh}
$ curl tinyurl.com/hlstinstall -L | bash
```

## Current features
- `.vimrc` - Custom vim config.
- **Binaries**
    - `hdiskcheck.sh` - Check if disks are passing a usage threshold 