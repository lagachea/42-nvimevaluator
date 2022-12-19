BLUE = "\\033[36m"
RED = "\\033[31m"
WHITE = "\\033[0m"
GREEN = "\\033[32m"
PURPLE = "\\033[35m"
YELLOW = "\\033[33m"
KBLU =  "\\033[34m"

LNECLR = "\\33[2K\\r"

all : run

bakup :
	touch .bakup
	[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak || printf "$(LNECLR)\n$(YELLOW) No local plugin installed. $(WHITE)\n\n"
	[ -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak || printf "$(LNECLR)\n$(YELLOW) No local configuration installed. $(WHITE)\n\n"
	
run :
	[ -f ./nvim-linux64/bin/nvim ] && ./nvim-linux64/bin/nvim && printf "$(LNECLR)$(RED)\nDon't forget to [ $(PURPLE)make restore$(RED) ] when you are finish !$(WHITE)\n\n" || printf "$(LNECLR)\nYou need to run [ $(PURPLE)make install$(WHITE) ]\n\n"

install : bakup
	./neovim.sh
	mkdir -p ~/.config/nvim
	cp init.lua ~/.config/nvim/init.lua
	printf "$(LNECLR)\n$(GREEN)[ $(PURPLE)make install $(GREEN)] was a success$(WHITE)\n\n"
	printf "$(LNECLR)\nYou can now run [ $(PURPLE)make$(WHITE) ]\n\n           or [ $(PURPLE)make run$(WHITE) ]\n\n"
	[ -f ./nvim-linux64/bin/nvim ] && ./nvim-linux64/bin/nvim && printf "$(LNECLR)$(RED)\nDon't forget to [ $(PURPLE)make restore$(RED) ] when you are finish !$(WHITE)\n\n" || printf "$(LNECLR)\nYou need to run [ $(PURPLE)make install$(WHITE) ]\n\n"

clean :
	rm -rf nvim-linux64
	[ -f ./.bakup ] && rm -rf ~/.local/share/nvim || printf "$(LNECLR)\n$(YELLOW) No local plugin to clean. $(WHITE)\n\n"
	[ -f ./.bakup ] && rm -rf ~/.config/nvim || printf "$(LNECLR)\n$(YELLOW) No local configuration to clean. $(WHITE)\n\n"
	rm -rf .bakup || printf "$(LNECLR)\n$(YELLOW) No bakup. $(WHITE)\n\n"
	printf "$(LNECLR)\n$(GREEN)[ $(PURPLE)make clean $(GREEN)] was a success$(WHITE)\n\n"

restore : clean
	[ -d ~/.local/share/nvim.bak ] && mv ~/.local/share/nvim.bak ~/.local/share/nvim || printf "$(LNECLR)\n$(YELLOW) No local plugin to restore. $(WHITE)\n\n"
	[ -L ~/.config/nvim.bak ] && mv ~/.config/nvim.bak ~/.config/nvim || printf "$(LNECLR)\n$(YELLOW) No local configuration to restore. $(WHITE)\n\n"
	printf "$(LNECLR)\n$(GREEN)[ $(PURPLE)make restore $(GREEN)] was a success$(WHITE)\n\n"

.SILENT : all bakup run install clean restore
