# Dotbox

[![Build Status](https://travis-ci.org/yesmeck/dotbox.png?branch=master)](https://travis-ci.org/yesmeck/dotbox)

Backup your dotfiles to dropbox and restore them easily.

## Installation

```
gem i dotbox
```

## Usage

```
$ dotbox -h
Tasks:
  dotbox add          # Backup the file
  dotbox help [TASK]  # Describe available tasks or one specific task
  dotbox remove       # Remove the backuped file
  dotbox restore      # Restore all backuped files
  dotbox setup        # Setup bakbox
```

## How does it works?

Suppose that we have a file named `/home/meck/.zshrc`.

When you run `dotbox add .zshrc`, it equals running following commands:
```
$ mv /home/meck/.zshrc /home/meck/Dropbox/Apps/Dotbox/.zshrc
$ ln -s /home/meck/Dropbox/Apps/Dotbox/.zshrc /home/meck/.zshrc
```

When you run `dotbox remove .zshrc`, it equals running following commands:
```
$ rm /home/meck/.zshrc
$ mv /home/meck/Dropbox/Apps/Dotbox/.zshrc /home/meck.zshrc
```

When you run `dotbox restore` it will link all files in dropbox to  their original positions.

## Not only dotfiles

Acturally, dotbox can take care of any files or directories under your $HOME directory. For example:
```
$ dotbox add .oh-my-fish/custom
```

