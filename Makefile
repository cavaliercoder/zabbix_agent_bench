APP = zabbix_agent_bench
APPVER = 0.1.0
ARCH = $(shell uname -i)
TARBALL = $(APP)-$(APPVER).$(ARCH)

GO = go
GFLAGS = -x
RM = rm -f
FPM = fpm
TAR = tar

all: $(APP)

$(APP): main.go zabbix_get.go
	$(GO) build $(GFLAGS)

clean:
	$(GO) clean
	$(RM) -f $(APP).tar.gz

tar: zabbix_agent_bench README.md keys/
	mkdir $(TARBALL)
	cp -r $(APP) README.md keys/ $(TARBALL)/
	$(TAR) -czf $(TARBALL).tar.gz $(TARBALL)/
	rm -rf $(TARBALL)/

rpm: zabbix_agent_bench
	$(FPM) -f -s dir -t rpm -n $(APP) -v $(APPVER) $(APP)=/usr/bin/$(APP)
