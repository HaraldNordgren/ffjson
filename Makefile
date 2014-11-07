
all: test install
	@echo "Done"

install:
	go install github.com/pquerna/ffjson

deps:

fmt:
	go fmt github.com/pquerna/ffjson/...

test-core:
	go test -v github.com/pquerna/ffjson/scanner github.com/pquerna/ffjson github.com/pquerna/ffjson/generator github.com/pquerna/ffjson/inception github.com/pquerna/ffjson/pills

test: ffize test-core
	go test -v github.com/pquerna/ffjson/tests/...

ffize: install
	ffjson tests/ff.go
	ffjson tests/goser/ff/goser.go
	ffjson tests/go.stripe/ff/customer.go
	ffjson tests/types/ff/everything.go

bench: ffize all
	go test -v -benchmem -bench MarshalJSON  github.com/pquerna/ffjson/tests/goser github.com/pquerna/ffjson/tests/go.stripe
	go test -v -benchmem -bench UnmarshalJSON  github.com/pquerna/ffjson/tests/goser github.com/pquerna/ffjson/tests/go.stripe

clean:
	go clean -i github.com/pquerna/ffjson/...
	rm -f tests/*/ff/*_ffjson.go tests/*_ffjson.go

.PHONY: deps clean test fmt install all
