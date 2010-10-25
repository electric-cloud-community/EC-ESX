# Makefile

SRCTOP=..

include $(SRCTOP)/build/vars.mak

PLUGIN_PATCH_LEVEL=1.1.0

# Don't show detailed "deprecated api" warnings until the plugin has been
# migrated to the "new style".  After migration, this line should be removed.
SHOW_DEPRECATED = "off"

gwtmodules := esx/ConfigurationManagement

build: buildJavaPlugin
unittest: 
systemtest: systemtest-setup mysystemtest-run

systemtest-setup:
	$(EC_PERL) systemtest/setup.pl $(TEST_SERVER) $(PLUGINS_ARTIFACTS)

mysystemtest-run: NTESTFILES ?= systemtest

mysystemtest-run:
	@-mkdir -p "$(OUTDIR)/$(ARCH)"
	COMMANDER_PLUGIN_PERL="../../../staging/agent/perl" \
	COMMANDER_JOBSTEPID="" \
	COMMANDER_DEBUG=1 \
	COMMANDER_DEBUGFILE="$(OUTDIR)/$(ARCH)/systemtest.log" \
	$(EC_PERL) $(NTEST) --testout $(OUTDIR)/$(ARCH)/systemtest \
		--target $(TEST_SERVER) $(NTESTARGS) $(NTESTFILES)

include $(SRCTOP)/build/rules.mak
