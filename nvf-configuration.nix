{ pkgs, lib, ... }:

{
        vim.options = {
        tabstop = 4;
        shiftwidth = 4;
        softtabstop = 4;
        expandtab = true;

        # Uses system clipboard
        clipboard = "unnamedplus";
        };

	vim = {
	  luaConfigRC.amane = lib.nvim.dag.entryAnywhere (builtins.readFile ./nvf-amane.lua);
	  theme = {
	  enable = true;
	  name = "tokyonight";
	  style = "night";
	  };

	  statusline.lualine.enable = true;
	  telescope.enable = true;
	  autocomplete.nvim-cmp.enable = true;

	  languages = {
	    enableTreesitter = true;	

	    nix.enable = true;
	    typescript.enable = true;
	    rust.enable = true;
	    python.enable = true;
	  };
	};

}
