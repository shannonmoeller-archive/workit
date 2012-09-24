# Phony

all: node_modules
	./node_modules/.bin/coffee -o lib -c src

clean:
	$(RM) -r lib

distclean:
	$(RM) -r node_modules

test: all
	./node_modules/.bin/forever bin/workit test

watch: node_modules
	./node_modules/.bin/coffee -o lib -cw src

.PHONY: all clean distclean test watch

# Actual

node_modules:
	npm install
