GIT=git
CFG=config
GOL=--global

-include settings.conf
-include config

all: git_simple_set

git_simple_set:
	$(GIT) $(CFG) $(GOL) user.name "$(NAME)"
	$(GIT) $(CFG) $(GOL) user.EMAIL "$(EMAIL)"
	$(GIT) $(CFG) $(GOL) alias.br branch
	$(GIT) $(CFG) $(GOL) alias.co checkout
	$(GIT) $(CFG) $(GOL) alias.cp cherry-pick
	$(GIT) $(CFG) $(GOL) alias.st stash
	$(GIT) $(CFG) $(GOL) alias.sub submodule
	$(GIT) $(CFG) $(GOL) alias.tree "log --graph --full-history --color --date=short --pretty=format:\"%Cred%x09%h %Creset%ad %Cblue%d %Creset %C(yellow)%s %C(bold green)(%an)%Creset\""	
	$(GIT) $(CFG) $(GOL) core.editor vim
	$(GIT) $(CFG) $(GOL) color.ui true
	$(GIT) $(CFG) --list