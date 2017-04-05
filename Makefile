

link:
	./link_dotfiles

# SC1090: Can't follow non-constant source
SCARGS= -e 1090

test:
	shellcheck $(SCARGS) -s sh   profile
	shellcheck $(SCARGS) -s bash profile
	shellcheck $(SCARGS) -s bash bashrc
	shellcheck $(SCARGS) -s bash bash_profile
	shellcheck $(SCARGS)         link_dotfiles
	shellcheck $(SCARGS) -s sh   shinit
	shellcheck $(SCARGS) -s bash shinit

clean:
	rm *~
