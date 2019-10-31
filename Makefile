.PHONY: solc-compile

solidity_code := $(wildcard solidity/*/*.sol)

solidity/%.sol.evm: solidity/%.sol
	solc --bin $< | tail -n1 > $@

solc-compile: $(solidity_code:=.evm)
