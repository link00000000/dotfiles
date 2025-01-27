export XDG_CONFIG_HOME=.
export XDG_STATE_HOME=./.local/state
export XDG_DATA_HOME=./.local/share
export NVIM_APPNAME=nvim

.PHONY: run
run:
	nvim

.PHONY: clean
clean:
	rm -r "$(XDG_DATA_HOME)/$(NVIM_APPNAME)"
	rm -r "$(XDG_STATE_HOME)/$(NVIM_APPNAME)"
