
BUILDDIR=build

WREN:=deps/wren-cli.git/bin/wren_cli

VEERY:=$(WREN) $(BUILDDIR)/bin/veery

.PHONY: all
all: build

.PHONY: ckeck
check: check-lang-veery check-lang-wren

check-lang-veery: all
	@echo "TODO: expand check-lang-veery"

check-lang-wren: all
	@for TEST_FILE in $(shell find $(BUILDDIR) -type f); do \
		echo $(VEERY) analyze --lang=wren "$${TEST_FILE}"; \
		$(VEERY) analyze --lang=wren "$${TEST_FILE}"; \
	done
	@echo "TODO: expand check-lang-wren"

.PHONY: update-stage0
update-stage0: stage3 clean-stage0 stage0

.PHONY: stage0
stage0: stage3
	make -f Makefile.stage BUILDDIR="stage0" VEERY="$(WREN) stage3/bin/veery" VEERY_ARGS="$(VEERY_ARGS)" bootstrap

.PHONY: stage1
stage1:
	make -f Makefile.stage BUILDDIR="stage1" VEERY="$(WREN) stage0/bin/veery" VEERY_ARGS="$(VEERY_BOOTSTRAP_ARGS)" bootstrap

.PHONY: stage2
stage2: stage1
	make -f Makefile.stage BUILDDIR="stage2" VEERY="$(WREN) stage1/bin/veery" VEERY_ARGS="$(VEERY_ARGS)" all

.PHONY: stage3
stage3: stage2
	make -f Makefile.stage BUILDDIR="stage3" VEERY="$(WREN) stage2/bin/veery" VEERY_ARGS="$(VEERY_ARGS)" all

	# Test for a sound build
	diff -rq stage2 stage3

.PHONY: build
build: stage3
	make -f Makefile.stage BUILDDIR="$(BUILDDIR)" VEERY="$(WREN) stage3/bin/veery" all

.PHONY: run-shell
run-shell: build
	$(VEERY) shell

.PHONY: run-veery-shell
run-veery-shell: build
	$(VEERY) shell --lang=veery

.PHONY: run-wren-shell
run-wren-shell: build
	$(VEERY) shell --lang=wren

.PHONY: clean
clean:
	make -f Makefile.stage BUILDDIR="stage1" clean
	make -f Makefile.stage BUILDDIR="stage2" clean
	make -f Makefile.stage BUILDDIR="stage3" clean
	make -f Makefile.stage BUILDDIR="$(BUILDDIR)" clean

.PHONY: clean-stage0
clean-stage0:
	rm -rf stage0

.PHONY: mrproper
mrproper:
	# rm -rf stage0 # Preserve stage0
	rm -rf stage1
	rm -rf stage2
	rm -rf stage3
	# rm -rf $(BUILDDIR) # Preserve in case user use BUILDDIR=.
