local lspconfig = require("lspconfig")


lspconfig.dockerls.setup({
    settings = {
        docker = {
	        languageserver = {
	            formatter = {
		            ignoreMultilineInstructions = true,
		        }
	        }
	    }
    }
})
