<p align="center">
  <img width="320" src="https://github.com/rogerchan1226/DEBuild/blob/master/DEBuild_logo.png">
</p>

<p align="center">
<a href="https://github.com/rogerchan1226/DEBuild/releases">
<img src="https://img.shields.io/github/release/rogerchan1226/DEBuild" alt="GitHub release">
</a>
<a href="https://github.com/rogerchan1226/DEBuild/blob/master/LICENSE">
<img src="https://img.shields.io/github/license/mashape/apistatus.svg" alt="license">
</a>
</p>

DEBuild (Develop Environment Build) this project idea was come out when I trying to build up my linux OS on VirtualBox. It can help to build up all tools and environment automatically, before you start your devalop job.<br>

__Also let myself get familiar with Shell Script & Makefile langurages.__

I know that name "DEB" will let you little bit confuse with Linux package format ".deb". But... too late! I'm lazy to change it lol!!! 😬

## Getting Started

### Prerequisites

__Warning:__ _DEBuild now only works on Debain-based Linux.(It will be support Fedora-based & MacOS lately)_

* You don't have to install anything before launch this tool.
* Set up package settings at `src/config` file before launch this tool.
* Make sure your terminal `cd` to `DEBuild` path.
* Type `sudo ./DEBuild_linux.sh` to launch it.

## Packages supported

__DEBuild now release as Beta version.__
In Beta version, I focus on program structure like program working flow, bugs ...etc. So now only support few packages only. I will fill in more packages installation soon in near future.

_These packages all possible to turn off by modify `src/config` file._
* Git
* C develop environment (build-essential)
* Several C libraries
* Sublime IDE (Stable/Development version)

## Update message
Please refer to "Commit" message.
