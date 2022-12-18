all : run

bakup :
	[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak
	[ -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
	
run :
	[ -f ./nvim-linux64/bin/nvim ] && ./nvim-linux64/bin/nvim || printf "run make install\n"

install : bakup
	./neovim.sh
	mkdir -p ~/.config/nvim
	cp init.lua ~/.config/nvim/init.lua

clean :
	[ -d nvim-linux64 ] && rm -rf nvim-linux64
	[ -d ~/.local/share/nvim.bak ] && rm -rf ~/.local/share/nvim
	[ -L ~/.config/nvim.bak ] && rm -rf ~/.config/nvim

restore : clean
	[ -d ~/.local/share/nvim.bak ] && mv ~/.local/share/nvim.bak ~/.local/share/nvim
	[ -L ~/.config/nvim.bak ] && mv ~/.config/nvim.bak ~/.config/nvim

.SILENT : run all
