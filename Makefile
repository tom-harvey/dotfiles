
install:
	tic -x -o terminfo xterm-256color-italic.terminfo
	tic -x -o terminfo tmux-256color.terminfo
	./link_dotfiles

# SC1090: Can't follow non-constant source
SCARGS= -e 1090

test:
	shellcheck $(SCARGS) -s sh   profile
	shellcheck $(SCARGS) -s bash profile
	shellcheck $(SCARGS) -s dash profile
	shellcheck $(SCARGS) -s ksh  profile
	shellcheck $(SCARGS) -s bash bashrc
	shellcheck $(SCARGS) -s bash bash_profile
	shellcheck $(SCARGS)         link_dotfiles
	shellcheck $(SCARGS) -s sh   shrc
	shellcheck $(SCARGS) -s bash shrc
	shellcheck $(SCARGS) -s dash shrc
	shellcheck $(SCARGS) -s ksh  shrc

clean:
	rm ~/dbg_start *~
