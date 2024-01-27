---
title: Git Walkthrough
layout: walkthrough
permalink: /:path/:basename
---
Git is a Distributed Version Control System which means that it:

* Manages source code
* Tracks all changes, who made them, and when
* Coordinates multiple people working on the same project
* Saves you from mistakes
* Protects you from hardware or software failures

[Git](https://git-scm.com/) isn't the first or only Version Control system. An early and popular one was CVS (Concurrent Versions System). [Mercurial](https://www.mercurial-scm.org/) remains popular and Microsoft SourceSafe was integrated into Visual Studio for many years.

Git was created in 2005 by Linus Torvalds as a better system for managing development of Linux. Since then it has gained enormous popularity.

Git is not the same thing as [GitHub](https://github.com). Git can synchronize with remote source code repositories including [GitHub](https://github.com) (which we will use in this class), [SourceForge](https://sourceforge.net/), [Bitbucket](https://bitbucket.org/), and [GitLab](https://about.gitlab.com/).

## Git Vocabulary
* Repo – A repository of source code that is managed by Git
* Commit – A set of source code changes that are committed to the repo.
* Remote – A shared copy of a repository on a managed service such as GitHub
* Push – Copy your commits to a remote
* Pull – Retrieve and merge commits from a remote
* Sync – Pull then push
* Branch – A set of commits that are isolated from the main trunk with the intention of merging them later.
* Fork – A copy of a repo on which new commits are made that diverge from the original.
* Pull request – A request for a repo manager to merge in a set of commits from a branch or fork.

## Installing Git
Git is included with most Linux distributions. For Windows and Mac, install from here: [https://git-scm.com/downloads](https://git-scm.com/downloads).

The Git installer has 12 pages of options. In most cases, the default settings are best. Here are my preferences for non-defaults:

* (Windows 11 only) Turn on "Add a Git Bash Profile to Windows Terminal". This facilitates you using Bash as a Windows shell.
* **Important:** Set the "default editor used by Git" to "Use Visual Studio Code as Git's default editor."
* Set "Override the default branch name for new repositories" to "main".
* If you often use Windows PowerShell and/or the legacy "Command Prompt" then turning on "Use Git and optional Unix tools from the Command Prompt" will let you use Linux commands like "ls", "grep", "find", and "sort" from the legacy Windows command line. But first check the warning on this setting.

On Windows, Git will include Git Bash which is a Unix-Style Bash shell running on Windows.

## Basic Walkthrough

Open a command line that has access to Git. This could be on a Linux box, on the macOS Terminal, Git Bash on Windows, or the Linux Subsystem for Windows. It doesn't much matter.

Make sure Git is installed and check the version number.
```
git -v
```

Create a directory for your repository and change to that directory.
```
mkdir MyRepo
cd MyRepo
```

Create a file called `README.md`` with some text in it.
```
echo Some Text >README.md
```

You now have a directory with one file in it. We will make this directory into a Git **repo** (repository); set all files to be tracked by Git (there's only one); and commit those changes to the repo.
```
git init
git add *
git commit -m "My first commit."
```

> Be careful when you commit changes from the command line. The `-m` option indicates a message that describes the commit. If you leave that option off, then Git will launch its default text editor and wait for you enter a message. If that editor is not familiar to you (e.g. Nano) then you may have a hard time figuring out what to do.

Add some text to the `README.md` file. You can do that using the command below or open it in your favorite text editor.
```
echo Some more text >>README.md
```

Check the status of your repo.
```
git status
```

It tells you that you have one file that has been modified since your last commit. Now commit those changes.
```
git add *
git commit -m "My second commit."
```

Now let's look at your commit history.
```
git log
```

It shows you all commits you have made with the most recent one first. You may have to type `q` to get out of the pagination. Each commit is identified by a big number. That number is the [SHA-1 Hash](https://en.wikipedia.org/wiki/SHA-1) of all contents of that particular commit.

> While SHA-1 is deprecated for cryptographic purposes, Git simply uses the hash as a unique identifier of the commit. Accordingly, using the algorithm in this context is not a significant security risk.

### Create a repo on GitHub

Now, you will make a remote copy of your repo on GitHub. To do this, open [https://github.com](https://github.com) in your web browser.
* In the `Repositories` panel on the left click `New`
* No Repository Template
* Choose your own account as the owner
* Name the repository something like `MyRepo`. Typically the name of the repo on GitHub will match the name of the directory on your local machine. This reduces confusion.
* Set the repo to be private - unless you want to share it wit the world.
* For this round, do not add a README, a .gitignore, or a license.
* Click `Create repository`

### Connect your local repo to the one on GitHub

Conveniently, GitHub shows you the exact commands you need to do this. On your command-line type the following (for `git remote add origin` substitute the path that GitHub includes in the instructions)
```
git remote add origin https://github.com/<your username>/MyRepo.git
git branch -M main
git push -u origin main
```

>Git may prompt you for your GitHub username and password. If so, your username is simply the one you use to log into GitHub. However, for security reasons it will not accept your regular GitHub password. Instead, follow the instructions [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-personal-access-token-classic) to create a Classic Personal Access Token and use that token to as the password.

These commands do the following:
1. Connect the remote copy on GitHub to your local repo.
2. Rename the current branch to "main". Depending on your Git settings it may already be "main" or it might be "master".
3. Push everything from your local repo to the remote copy on GitHub.

### Make one more change, commit it, and push it to GitHub

Make one more change to your repo. You could add another file, add a line to README.md, or use an editor to make a change to README.md.

```
echo One more change >>README.md
```

Commit that change.
```
git add *
git commit -m "One more change."
```

Push the change to GitHub
```
git push
```

If you are using Visual Studio Code for your editor, you can use the GUI to do the same thing. Enter a commit message and click "Commit", then click "Sync Changes".

### View the repo on GitHub

Now that you have a copy of your repo on GitHub you can view it there. Refresh the page and it will show your README.md file, the number of commits you have made, and a bunch of other information. Click on "commits" and it will show you your history. Click on any one of those commits and it will show the changes made in that commit.

### Clone the repo to a new directory and make a change

Typically you would clone a repo if you need the code on a different machine. Or you would clone a repo if you are switching to a new computer or if you are collaborating with others on the same project. However, for this project we will simply clone the repo into another directory - just to show how it's done.

Change to the parent directory and create a new directory for the clone.
```
cd ..
mkdir MyClone
cd MyClone
```

To clone the repo you need the URL of the repo on GitHub. From the home page of the repo click on the big green "Code" button and it will show you the URL of your repo. It should end in ".git" and it will be the same URL you used with the `git remote add origin` command. Substitute that URL in the command below:
```
git clone https://github.com/<your username>/MyRepo.git
```

The clone will be in a subdirectory of `MyClone` called `MyRepo`. Change to that directory.
```
cd MyRepo
```


Make a change in the clone such as adding a file, adding a line to README.md or editing a file.
```
echo Enter the clones >>README.md
```

Commit the change and push it to GitHub
```
git add *
git commit -m "Clone change"
git push
```

### Go back to the original directory and pull the change from GitHub

Switch back to the original directory
```
cd ../../MyRepo
```

Pull the latest changes
```
git pull
```

Look at the files and see that the changes you made in the clone are also in the original directory.