BLUE = "\\033[36m"
RED = "\\033[31m"
WHITE = "\\033[0m"
GREEN = "\\033[32m"
PURPLE = "\\033[35m"
YELLOW = "\\033[33m"
KBLU =  "\\033[34m"

LNECLR = "\\33[2K\\r"

APPNAME=tmp-nvim


all: run

run:
	[ -f ./nvim-linux64/bin/nvim ] && NVIM_APPNAME=$(APPNAME) ./nvim-linux64/bin/nvim && printf "$(LNECLR)$(RED)\nDon't forget to [ $(PURPLE)make clean$(RED) ] when you are done !$(WHITE)\n\n" || printf "$(LNECLR)\nYou need to run [ $(PURPLE)make install$(WHITE) ]\n\n"

install: clean
	./neovim.sh
	./choose-config.sh
	mkdir -p ~/.config/$(APPNAME)
	[ -d config ] && cp -r -t ~/.config/$(APPNAME) config/* || cp init.lua ~/.config/$(APPNAME)/init.lua
	printf "$(LNECLR)\n$(GREEN)[ $(PURPLE)make install $(GREEN)] was a success$(WHITE)\n\n"
	printf "$(LNECLR)\nYou can now run [ $(PURPLE)make$(WHITE) ]\n\n           or [ $(PURPLE)make run$(WHITE) ]\n\n"
	[ -f ./nvim-linux64/bin/nvim ] && NVIM_APPNAME=$(APPNAME) ./nvim-linux64/bin/nvim && printf "$(LNECLR)$(RED)\nDon't forget to [ $(PURPLE)make clean$(RED) ] when you are done !$(WHITE)\n\n" || printf "$(LNECLR)\nYou need to run [ $(PURPLE)make install$(WHITE) ]\n\n"

clean:
	rm -rf nvim-linux64 config ~/.local/state/$(APPNAME) ~/.local/share/$(APPNAME) ~/.config/$(APPNAME) && printf "$(LNECLR)\n$(GREEN)[ $(PURPLE)make clean $(GREEN)] was a success$(WHITE)\n\n"

.SILENT: all run install clean
