ALL_PROTO_FILES=$(shell find . -name *.proto)

_protoc_cmd = @docker run -v `pwd`:/proto-sources:ro -w /proto-sources --rm brennovich/protobuf-tools:2.3.0

clean:
	@echo "Cleaning Examples..."
	rm -rf examples/compiled examples/resources/

validate/python:
	@echo "Building for python..."
	$(_protoc_cmd) protoc --python_out=/tmp ${ALL_PROTO_FILES}

validate/java:
	@echo "Building for java..."
	$(_protoc_cmd) protoc --java_out=/tmp ${ALL_PROTO_FILES}

validate/go:
	@echo "Building for go..."
	$(_protoc_cmd) protowrap -I . --go_out=/tmp ${ALL_PROTO_FILES}

validate/js:
	@echo "Building for javascript..."
	$(_protoc_cmd) protoc --js_out=/tmp ${ALL_PROTO_FILES}

validate: clean validate/go validate/java validate/python validate/js
