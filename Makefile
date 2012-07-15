.PHONY: all clean distclean watch

all: node_modules
	./node_modules/.bin/coffee -o lib -c src

clean:
	$(RM) -r lib

distclean:
	$(RM) -r node_modules

watch: node_modules
	./node_modules/.bin/coffee -o lib -cw src

node_modules:
	npm install
