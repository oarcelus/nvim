local companion = require("codecompanion")
companion.setup({

  strategies = {
    chat = {
      adapter = "openai_compatible",
    },
    inline = {
      adapter = "openai_compatible",
    },
    agent = {
      adapter = "openai_compatible",
    },
  },

	adapters = {
		openai_compatible = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = "https://openrouter.ai/api",
					api_key = "cmd: gpg --batch --quiet --decrypt /home/oarcelus/credentials/openrouter.gpg",
					chat_url = "/v1/chat/completions",
				},
				schema = {
					model = {
						default = "anthropic/claude-3.7-sonnet",
					},
				},
			})
		end,
	},
})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "codecompanion" },
	},
})
