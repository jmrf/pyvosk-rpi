clean:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +
	find . -name 'README.md.*' -exec rm -f  {} +
	rm -rf build/
	rm -rf .pytype/
	rm -rf dist/
	rm -rf docs/_build
	# rm -rf *egg-info
	# rm -rf pip-wheel-metadata

init-multi-build:
	bash init_multi-build.sh

build-test-docker:
	docker buildx build --push \
		--platform linux/arm/v7 \
		-t jmrf/pyvosk-test:0.3.32-cp37 \
		-f dockerfiles/Dockerfile.test .

build-vosk-server-docker:
	docker buildx build --push \
		--platform linux/arm/v7 \
		-t jmrf/vosk-server:0.3.32-cp37 \
		-f dockerfiles/Dockerfile.vosk-server .

run-test-docker:
	docker run -it \
		--device /dev/snd:/dev/snd \
		--entrypoint /bin/bash  \
		jmrf/pyvosk-test:0.3.32-cp37

run-vosk-server-docker:
	docker run -it \
		-p 2700:2700 \
		jmrf/vosk-server:0.3.32-cp37

tag:
	git tag $$( python -c 'import .; print(..__version__)' )
	git push --tags


readme-toc:
	# https://github.com/ekalinin/github-markdown-toc
	find . \
		! -path './kaldi/*' \
		! -path './.venv/*' \
		-name README.md \
		-exec gh-md-toc --insert {} \;

