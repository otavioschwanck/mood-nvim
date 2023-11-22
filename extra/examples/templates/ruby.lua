local utils = require("new-file-template.utils")

local function generate_module_structure(yield, qtd_dirs_to_hide, path)
	local directories = {}
	for dir in path:gmatch("[^/]+") do
		table.insert(directories, dir)
	end

	if qtd_dirs_to_hide >= #directories then
		return "# frozen_string_literal: true\n\n" .. yield
	end

	for _ = 1, qtd_dirs_to_hide do
		table.remove(directories, 1)
	end

	local moduleStructure = ""
	local indentation = ""
	for _, dir in ipairs(directories) do
		moduleStructure = moduleStructure .. indentation .. "module " .. utils.snake_to_class_camel(dir) .. "\n"
		indentation = indentation .. "  "
	end

	local classLines = {}
	local classIndentation = indentation:sub(1, -3) .. "  "
	for line in yield:gmatch("[^\n]+") do
		table.insert(classLines, classIndentation .. line)
	end
	yield = table.concat(classLines, "\n")

	moduleStructure = moduleStructure .. yield .. "\n"

	for _ = #directories, 1, -1 do
		indentation = indentation:sub(1, -3)
		moduleStructure = moduleStructure .. indentation .. "end\n"
	end

	return "# frozen_string_literal: true\n\n" .. moduleStructure:sub(1, -2)
end

local function get_class_name(filename)
	return utils.snake_to_class_camel(vim.split(filename, "%.")[1])
end

local function inheritance_class(filename, class)
	return [[
class ]] .. get_class_name(filename) .. " < " .. class .. [[

  |cursor|
end]]
end

local function base_template(path, filename)
	local is_call

	while not (is_call == "1") and not (is_call == "2") do
		print("Você tá criando uma classe do ChainApi. Como você deseja criar ela?")
		is_call = vim.fn.input("1 - CallBase. 2 - ReadBase >> ")
	end

	local inheritance

	if is_call == "1" then
		inheritance = "CallBase"
	else
		inheritance = "ReadBase"
	end

	local class_text = string.format(
		[[
class %s < ChainApi::%s

  contract_address ChainApi::ChangeContractHere::CONTRACT_ADDRESS
  config :ContractName, :ContractFunction
  via_wallet { Wallet.amfi }\n

  def initialize|cursor|
  end\n

  def unique_key
    "Add A Unique Key Here"
  end\n

  def contract_args
    []
  end
end]],
		get_class_name(filename),
		inheritance
	)

	print(class_text)

	return generate_module_structure(class_text, 2, path)
end

local function create_service_template(path, filename)
	print(
		"Mood Tip: Para criar ou ir até o contrato referente a este service.  Digite: SPC f a (telescope-alternate plugin)"
	)

	local class_text = inheritance_class(filename, "CreateService")

	return generate_module_structure(class_text, 2, path)
end

local function update_service_template(path, filename)
	print(
		"Mood Tip: Para criar ou ir até o contrato referente a este service.  Digite: SPC f a (telescope-alternate plugin)"
	)

	local class_text = inheritance_class(filename, "UpdateService")

	return generate_module_structure(class_text, 2, path)
end

local function delete_service_template(path, filename)
	print(
		"Mood Tip: Para criar ou ir até o contrato referente a este service.  Digite: SPC f a (telescope-alternate plugin)"
	)

	local class_text = inheritance_class(filename, "DeleteService")

	return generate_module_structure(class_text, 2, path)
end

local function contract_template(path, filename)
	print(
		"Mood Tip: Para criar ou ir até o service referente a este contrato.  Digite: SPC f a (telescope-alternate plugin)"
	)

	local class_text = inheritance_class(filename, "BaseContract")

	return generate_module_structure(class_text, 2, path)
end

--- @param opts table
---   A table containing the following fields:
---   - `full_path` (string): The full path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `relative_path` (string): The relative path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `filename` (string): The filename of the new file, e.g., "init.lua".
return function(opts)
	local template = {
		{ pattern = "app/services/.*_services/create.rb", content = create_service_template },
		{ pattern = "app/services/.*_services/delete.rb", content = delete_service_template },
		{ pattern = "app/services/.*_services/.*.rb", content = update_service_template },
		{ pattern = "app/contracts/.*_contracts/.*.rb", content = contract_template },
		{ pattern = "app/business/chain_api/.*/.*", content = base_template },
	}

	return utils.find_entry(template, opts)
end
